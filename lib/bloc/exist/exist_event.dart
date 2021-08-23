import 'package:equatable/equatable.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

@immutable
abstract class ExistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ExistRequest extends ExistEvent {
  final SavedTrain savedTrain;

  ExistRequest({@required this.savedTrain});

  @override
  List<Object> get props => [savedTrain];
}