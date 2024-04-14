import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedStation.dart';

@immutable
abstract class StationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStations extends StationsEvent {}

class UpdateFavorite extends StationsEvent {
  final SavedStation savedStation;

  UpdateFavorite({required this.savedStation});

  @override
  List<Object?> get props => [savedStation];
}
