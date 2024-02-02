import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/SavedTrain.dart';

@immutable
abstract class FavouritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouritesRequest extends FavouritesEvent {}

class DeleteFavourite extends FavouritesEvent {
  final SavedTrain savedTrain;

  DeleteFavourite({required this.savedTrain});

  @override
  List<Object?> get props => [savedTrain];
}

class ReorderFavourites extends FavouritesEvent {
  final int oldIndex;
  final int newIndex;

  ReorderFavourites({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
