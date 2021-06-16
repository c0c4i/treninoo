import 'package:treninoo/model/DepartureStation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/utils/final.dart';

abstract class DepartureStationState extends Equatable {
  @override
  List<Object> get props => [];
}

class DepartureStationInitial extends DepartureStationState {}

class DepartureStationLoading extends DepartureStationState {}

class DepartureStationSuccess extends DepartureStationState {
  final List<DepartureStation> departureStations;

  DepartureStationSuccess({@required this.departureStations});

  @override
  List<Object> get props => [departureStations];
}

class DepartureStationFailed extends DepartureStationState {}
