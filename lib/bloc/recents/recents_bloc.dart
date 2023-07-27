import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/bloc/recents/recents.dart';

import '../../repository/saved_train.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final SavedTrainRepository _savedTrainRepository;

  RecentsBloc(SavedTrainRepository savedTrainRepository)
      : _savedTrainRepository = savedTrainRepository,
        super(RecentsInitial()) {
    on<RecentsRequest>(_mapRecentsRequest);
    on<DeleteRecent>(_mapDeleteRecentRequest);
  }

  Future<void> _mapRecentsRequest(
      RecentsRequest event, Emitter<RecentsState> emit) async {
    emit(RecentsLoading());
    try {
      final trains = _savedTrainRepository.getRecents();
      emit(RecentsSuccess(trains: trains));
    } catch (e) {
      emit(RecentsFailed());
    }
  }

  Future<void> _mapDeleteRecentRequest(
      DeleteRecent event, Emitter<RecentsState> emit) async {
    emit(RecentsLoading());
    try {
      _savedTrainRepository.removeRecent(event.savedTrain);
      final trains = _savedTrainRepository.getRecents();
      emit(RecentsSuccess(trains: trains));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(RecentsFailed());
    }
  }
}
