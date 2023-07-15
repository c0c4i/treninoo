import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

@immutable
abstract class TrainStatusEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrainStatusRequest extends TrainStatusEvent {
  final SavedTrain? savedTrain;

  TrainStatusRequest({required this.savedTrain});

  @override
  List<Object?> get props => [savedTrain];
}
