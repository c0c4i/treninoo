import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/SavedTrain.dart';

@immutable
abstract class FavouritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesRequest extends FavouritesEvent {}

class DeleteFavourite extends FavouritesEvent {
  final SavedTrain savedTrain;

  DeleteFavourite({this.savedTrain});

  @override
  List<Object> get props => [savedTrain];
}
