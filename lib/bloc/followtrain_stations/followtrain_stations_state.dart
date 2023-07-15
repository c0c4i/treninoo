import 'package:equatable/equatable.dart';
import 'package:treninoo/model/Station.dart';

abstract class FollowTrainStationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowTrainStationsInitial extends FollowTrainStationsState {}

class FollowTrainStationsLoading extends FollowTrainStationsState {}

class FollowTrainStationsSuccess extends FollowTrainStationsState {
  final List<Station> stations;

  FollowTrainStationsSuccess({required this.stations});

  @override
  List<Object> get props => [stations];
}

class FollowTrainStationsFailed extends FollowTrainStationsState {}
