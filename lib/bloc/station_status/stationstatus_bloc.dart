import 'dart:async';
import 'package:bloc/bloc.dart';
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
        super(StationStatusInitial());

  @override
  Stream<StationStatusState> mapEventToState(
    StationStatusEvent event,
  ) async* {
    if (event is StationStatusRequest) {
      yield* _mapStationStatusRequest(event);
    }
  }

  Stream<StationStatusState> _mapStationStatusRequest(
      StationStatusRequest event) async* {
    yield StationStatusLoading();
    try {
      _savedTrainRepository.addRecentStation(event.station);
      final departureTrains =
          await _trainRepository.getDepartureTrains(event.station);
      final arrivalTrains =
          await _trainRepository.getArrivalTrains(event.station);
      yield StationStatusSuccess(
          departureTrains: departureTrains, arrivalTrains: arrivalTrains);
    } catch (e) {
      print(e);
      yield StationStatusFailed();
    }
  }
}
