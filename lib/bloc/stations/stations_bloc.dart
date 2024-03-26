import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/bloc/stations/stations_event.dart';
import 'package:treninoo/bloc/stations/stations_state.dart';
import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/repository/saved_station.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final SavedStationsRepository _savedStationsRepository;

  StationsBloc(SavedStationsRepository savedStationsRepository)
      : _savedStationsRepository = savedStationsRepository,
        super(StationsInitial()) {
    on<GetStations>(_mapStationsRequest);
    on<RemoveStation>(_mapDeleteStationRequest);
  }

  Future<void> _mapStationsRequest(
      GetStations event, Emitter<StationsState> emit) async {
    emit(StationsLoading());
    try {
      List<SavedStation> stations =
          _savedStationsRepository.getRecentsAndFavouritesStations();
      emit(StationsSuccess(stations: stations));
    } catch (e) {
      emit(StationsFailed());
    }
  }

  Future<void> _mapDeleteStationRequest(
      RemoveStation event, Emitter<StationsState> emit) async {
    emit(StationsLoading());
    try {
      _savedStationsRepository.removeFavoruiteStation(event.station);
      List<SavedStation> stations =
          _savedStationsRepository.getRecentsAndFavouritesStations();
      emit(StationsSuccess(stations: stations));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(StationsFailed());
    }
  }
}
