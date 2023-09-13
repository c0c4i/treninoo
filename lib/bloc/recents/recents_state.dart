import 'package:treninoo/model/SavedTrain.dart';
import 'package:equatable/equatable.dart';

abstract class RecentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentsInitial extends RecentsState {}

class RecentsLoading extends RecentsState {}

class RecentsSuccess extends RecentsState {
  final List<SavedTrain> trains;

  RecentsSuccess({required this.trains});

  @override
  List<Object> get props => [trains];
}

class RecentsFailed extends RecentsState {}
