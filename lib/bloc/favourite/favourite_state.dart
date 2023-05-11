import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FavouriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final bool isFavourite;

  FavouriteSuccess({@required this.isFavourite});

  @override
  List<Object> get props => [isFavourite];
}

class FavouriteFailed extends FavouriteState {}
