import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/SavedTrain.dart';

@immutable
abstract class RecentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecentsRequest extends RecentsEvent {}

class DeleteRecent extends RecentsEvent {
  final SavedTrain savedTrain;

  DeleteRecent({required this.savedTrain});

  @override
  List<Object?> get props => [savedTrain];
}
