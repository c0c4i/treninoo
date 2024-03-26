import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedStation.dart';

@immutable
abstract class StationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStations extends StationsEvent {}

class RemoveStation extends StationsEvent {
  final SavedStation station;

  RemoveStation({required this.station});

  @override
  List<Object?> get props => [station];
}
