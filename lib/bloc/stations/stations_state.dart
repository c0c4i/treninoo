import 'package:treninoo/model/SavedStation.dart';
import 'package:equatable/equatable.dart';

abstract class StationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationsInitial extends StationsState {}

class StationsLoading extends StationsState {}

class StationsSuccess extends StationsState {
  final List<SavedStation> stations;

  StationsSuccess({required this.stations});

  @override
  List<Object> get props => [stations];
}

class StationsFailed extends StationsState {}
