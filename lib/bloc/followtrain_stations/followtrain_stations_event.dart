import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/DepartureStation.dart';

@immutable
abstract class FollowTrainStationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowTrainStationsRequest extends FollowTrainStationsEvent {
  final DepartureStation departureStation;

  FollowTrainStationsRequest({@required this.departureStation});

  @override
  List<Object> get props => [departureStation];
}
