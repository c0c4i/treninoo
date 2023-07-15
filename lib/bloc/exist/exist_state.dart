import 'package:equatable/equatable.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/TrainInfo.dart';

import '../../enum/saved_train_type.dart';

abstract class ExistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExistInitial extends ExistState {}

class ExistLoading extends ExistState {}

class ExistSuccess extends ExistState {
  final TrainInfo trainInfo;

  ExistSuccess({required this.trainInfo});

  @override
  List<Object> get props => [trainInfo];
}

class ExistMoreThanOne extends ExistState {
  final SavedTrain? savedTrain;
  final List<Station> stations;

  ExistMoreThanOne({required this.savedTrain, required this.stations});

  @override
  List<Object?> get props => [savedTrain, stations];
}

class ExistFailed extends ExistState {
  final SavedTrain? savedTrain;
  final SavedTrainType? type;

  ExistFailed({required this.savedTrain, this.type});

  @override
  List<Object?> get props => [savedTrain, type];
}
