import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DepartureStationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DepartureStationRequest extends DepartureStationEvent {
  final String trainCode;

  DepartureStationRequest({@required this.trainCode});

  @override
  List<Object> get props => [trainCode];
}
