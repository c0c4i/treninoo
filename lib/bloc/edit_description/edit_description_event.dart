import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

@immutable
abstract class EditDescriptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditDescriptionRequest extends EditDescriptionEvent {
  final SavedTrain savedTrain;

  EditDescriptionRequest({required this.savedTrain});

  @override
  List<Object> get props => [savedTrain];
}
