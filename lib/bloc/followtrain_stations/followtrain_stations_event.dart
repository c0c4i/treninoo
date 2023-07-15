import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

@immutable
abstract class FollowTrainStationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FollowTrainStationsRequest extends FollowTrainStationsEvent {
  final SavedTrain? savedTrain;

  FollowTrainStationsRequest({required this.savedTrain});

  @override
  List<Object?> get props => [savedTrain];
}
