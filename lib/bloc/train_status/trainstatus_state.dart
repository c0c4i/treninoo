import 'package:treninoo/model/TrainInfo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TrainStatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrainStatusInitial extends TrainStatusState {}

class TrainStatusLoading extends TrainStatusState {}

class TrainStatusSuccess extends TrainStatusState {
  final TrainInfo trainInfo;

  TrainStatusSuccess({@required this.trainInfo});

  @override
  List<Object> get props => [trainInfo];
}

class TrainStatusFailed extends TrainStatusState {}
