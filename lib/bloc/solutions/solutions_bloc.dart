import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
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
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(SolutionsFailed());
    }
  }
}
