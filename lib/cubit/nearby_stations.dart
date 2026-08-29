import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treninoo/utils/nearby_stations_service.dart';

// --- States ---

abstract class NearbyStationsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NearbyStationsInitial extends NearbyStationsState {}

class NearbyStationsLoading extends NearbyStationsState {}

class NearbyStationsSuccess extends NearbyStationsState {
  final List<NearbyStation> stations;

  NearbyStationsSuccess({required this.stations});

  @override
  List<Object?> get props => [stations];
}

/// Location permission was denied or location services are off.
class NearbyStationsUnavailable extends NearbyStationsState {}

class NearbyStationsFailed extends NearbyStationsState {}

// --- Cubit ---

class NearbyStationsCubit extends Cubit<NearbyStationsState> {
  NearbyStationsCubit() : super(NearbyStationsInitial());

  Future<void> loadNearbyStations() async {
    _safeEmit(NearbyStationsLoading());
    try {
      final stations = await NearbyStationsService.getNearbyStations(limit: 5);
      if (stations.isEmpty) {
        _safeEmit(NearbyStationsUnavailable());
      } else {
        _safeEmit(NearbyStationsSuccess(stations: stations));
      }
    } catch (e) {
      _safeEmit(NearbyStationsFailed());
    }
  }

  void _safeEmit(NearbyStationsState state) {
    if (!isClosed) emit(state);
  }
}
