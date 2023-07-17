import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/repository/saved_train.dart';
import 'package:treninoo/repository/train.dart';

class SolutionsBloc extends Bloc<SolutionsEvent, SolutionsState> {
  final TrainRepository _trainRepository;
  final SavedTrainRepository _savedTrainRepository;

  SolutionsBloc(TrainRepository trainRepository,
      SavedTrainRepository savedTrainRepository)
      : _trainRepository = trainRepository,
        _savedTrainRepository = savedTrainRepository,
        super(SolutionsInitial()) {
    on<SolutionsRequest>(_mapSolutionsRequest);
  }

  Future<void> _mapSolutionsRequest(
      SolutionsRequest event, Emitter<SolutionsState> emit) async {
    emit(SolutionsLoading());
    try {
      final solutions =
          await _trainRepository.getSolutions(event.solutionsInfo);
      _savedTrainRepository
          .addRecentStation(event.solutionsInfo!.departureStation);
      _savedTrainRepository
          .addRecentStation(event.solutionsInfo!.arrivalStation);
      emit(SolutionsSuccess(solutions: solutions));
    } catch (e) {
      emit(SolutionsFailed());
    }
  }
}
