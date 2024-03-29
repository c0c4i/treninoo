import 'package:equatable/equatable.dart';
import 'package:treninoo/model/StationTrain.dart';

abstract class StationStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationStatusInitial extends StationStatusState {}

class StationStatusLoading extends StationStatusState {}

class StationStatusSuccess extends StationStatusState {
  final List<StationTrain> departureTrains;
  final List<StationTrain> arrivalTrains;

  StationStatusSuccess(
      {required this.departureTrains, required this.arrivalTrains});

  @override
  List<Object> get props => [departureTrains, arrivalTrains];
}

class StationStatusFailed extends StationStatusState {}
