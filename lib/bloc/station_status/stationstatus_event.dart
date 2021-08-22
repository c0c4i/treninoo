import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StationStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StationStatusRequest extends StationStatusEvent {
  final String trainCode;

  StationStatusRequest({@required this.trainCode});

  @override
  List<Object> get props => [trainCode];
}
