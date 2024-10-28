import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';
import 'package:treninoo/repository/saved_station.dart';
import 'package:treninoo/repository/train.dart';

class StationStatusBloc extends Bloc<StationStatusEvent, StationStatusState> {
  final TrainRepository _trainRepository;
  final SavedStationsRepository _savedStationsRepository;

  StationStatusBloc(TrainRepository trainRepository,
      SavedStationsRepository savedStationsRepository)
      : _trainRepository = trainRepository,
        _savedStationsRepository = savedStationsRepository,
        super(StationStatusInitial()) {
    on<StationStatusRequest>(_mapStationStatusRequest);
  }

  Future<void> _mapStationStatusRequest(
      StationStatusRequest event, Emitter<StationStatusState> emit) async {
    emit(StationStatusLoading());
    try {
      _savedStationsRepository.addRecentOrFavoruiteStation(event.station);
      final departureTrains = await _trainRepository.getStationDetails(
          event.station, StationDetailsType.departure);
      final arrivalTrains = await _trainRepository.getStationDetails(
          event.station, StationDetailsType.arrival);
      emit(StationStatusSuccess(
          departureTrains: departureTrains, arrivalTrains: arrivalTrains));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(StationStatusFailed());
    }
  }
}
