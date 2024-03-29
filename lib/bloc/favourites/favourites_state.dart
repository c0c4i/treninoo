import 'package:treninoo/model/SavedTrain.dart';
import 'package:equatable/equatable.dart';

abstract class FavouritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesSuccess extends FavouritesState {
  final List<SavedTrain> trains;

  FavouritesSuccess({required this.trains});

  @override
  List<Object> get props => [trains];
}

class FavouritesFailed extends FavouritesState {}
