import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/Station.dart';

@immutable
abstract class StationStatusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StationStatusRequest extends StationStatusEvent {
  final Station station;

  StationStatusRequest({required this.station});

  @override
  List<Object?> get props => [station];
}
