import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/final.dart';

class StationStatusBloc extends Bloc<StationStatusEvent, StationStatusState> {
  final TrainRepository _trainRepository;

  StationStatusBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
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
      final departureTrains =
          await _trainRepository.getDepartureTrains(event.stationCode);
      final arrivalTrains =
          await _trainRepository.getArrivalTrains(event.stationCode);
      yield StationStatusSuccess(
          departureTrains: departureTrains, arrivalTrains: arrivalTrains);
    } catch (e) {
      print(e);
      yield StationStatusFailed();
    }
  }
}
