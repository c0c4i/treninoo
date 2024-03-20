import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
          .addRecentOrFavoruiteStation(event.solutionsInfo.departureStation);
      _savedTrainRepository
          .addRecentOrFavoruiteStation(event.solutionsInfo.arrivalStation);
      emit(SolutionsSuccess(solutions: solutions));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(SolutionsFailed());
    }
  }
}
