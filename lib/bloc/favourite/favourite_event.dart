import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

@immutable
abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteRequest extends FavouriteEvent {
  final SavedTrain? savedTrain;

  FavouriteRequest({required this.savedTrain});

  @override
  List<Object?> get props => [savedTrain];
}

class FavouriteToggle extends FavouriteEvent {
  final SavedTrain? savedTrain;
  final bool value;

  FavouriteToggle({required this.savedTrain, required this.value});

  @override
  List<Object?> get props => [savedTrain, value];
}
