import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Solution.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/repository/saved_station.dart';
import 'package:treninoo/repository/train.dart';

class SolutionsBloc extends Bloc<SolutionsEvent, SolutionsState> {
  final TrainRepository _trainRepository;
  final SavedStationsRepository _savedStationsRepository;

  SolutionsBloc(TrainRepository trainRepository,
      SavedStationsRepository savedStationsRepository)
      : _trainRepository = trainRepository,
        _savedStationsRepository = savedStationsRepository,
        super(SolutionsInitial()) {
    on<SolutionsRequest>(_mapSolutionsRequest);
  }

  Future<void> _mapSolutionsRequest(
      SolutionsRequest event, Emitter<SolutionsState> emit) async {
    emit(SolutionsLoading());
    try {
      final solutions =
          await _trainRepository.getSolutions(event.solutionsInfo);
      _savedStationsRepository
          .addRecentOrFavoruiteStation(event.solutionsInfo.departureStation);
      _savedStationsRepository
          .addRecentOrFavoruiteStation(event.solutionsInfo.arrivalStation);
      emit(SolutionsSuccess(solutions: solutions));

      // For train in every solution, get train status and update the solution
      Map<TrainSolution, int> trainDelays = {};
      for (Solution solution in solutions.solutions) {
        for (TrainSolution train in solution.trains) {
          try {
            SavedTrain savedTrain = SavedTrain.fromSolution(train);
            TrainInfo trainInfo =
                await _trainRepository.getTrainStatus(savedTrain);

            // If train is already arrived, don't update the solution
            if (trainInfo.completed) continue;

            if (trainInfo.delay == null) continue;

            trainDelays[train] = trainInfo.delay!;
            Map<TrainSolution, int> newDelays = Map.from(trainDelays);

            // Update the solution
            emit(SolutionsSuccess(solutions: solutions, delays: newDelays));
          } catch (e) {}
        }
      }
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(SolutionsFailed());
    }
  }
}
