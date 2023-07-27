import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';
import 'package:treninoo/repository/train.dart';

import '../../repository/saved_train.dart';

class StationStatusBloc extends Bloc<StationStatusEvent, StationStatusState> {
  final TrainRepository _trainRepository;
  final SavedTrainRepository _savedTrainRepository;

  StationStatusBloc(TrainRepository trainRepository,
      SavedTrainRepository savedTrainRepository)
      : _trainRepository = trainRepository,
        _savedTrainRepository = savedTrainRepository,
        super(StationStatusInitial()) {
    on<StationStatusRequest>(_mapStationStatusRequest);
  }

  Future<void> _mapStationStatusRequest(
      StationStatusRequest event, Emitter<StationStatusState> emit) async {
    emit(StationStatusLoading());
    try {
      _savedTrainRepository.addRecentStation(event.station);
      final departureTrains =
          await _trainRepository.getDepartureTrains(event.station);
      final arrivalTrains =
          await _trainRepository.getArrivalTrains(event.station);
      emit(StationStatusSuccess(
          departureTrains: departureTrains, arrivalTrains: arrivalTrains));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(StationStatusFailed());
    }
  }
}
