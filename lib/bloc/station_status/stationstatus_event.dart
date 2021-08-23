import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StationStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StationStatusRequest extends StationStatusEvent {
  final String stationCode;

  StationStatusRequest({@required this.stationCode});

  @override
  List<Object> get props => [stationCode];
}
