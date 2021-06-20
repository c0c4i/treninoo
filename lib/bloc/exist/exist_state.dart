import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

abstract class ExistState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExistInitial extends ExistState {}

class ExistLoading extends ExistState {}

class ExistSuccess extends ExistState {
  final SavedTrain savedTrain;

  ExistSuccess({@required this.savedTrain});

  @override
  List<Object> get props => [savedTrain];
}

class ExistFailed extends ExistState {}
