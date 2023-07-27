import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/repository/train.dart';

import 'followtrain_stations_event.dart';
import 'followtrain_stations_state.dart';

class FollowTrainStationsBloc
    extends Bloc<FollowTrainStationsEvent, FollowTrainStationsState> {
  final TrainRepository _trainRepository;

  FollowTrainStationsBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(FollowTrainStationsInitial()) {
    on<FollowTrainStationsRequest>(_mapFollowTrainStationsRequest);
  }

  Future<void> _mapFollowTrainStationsRequest(FollowTrainStationsRequest event,
      Emitter<FollowTrainStationsState> emit) async {
    emit(FollowTrainStationsLoading());
    try {
      final stations =
          await _trainRepository.getFollowTrainStations(event.savedTrain);
      emit(FollowTrainStationsSuccess(stations: stations));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(FollowTrainStationsFailed());
    }
  }
}
