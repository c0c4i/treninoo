import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';

import '../../enum/saved_train_type.dart';

@immutable
abstract class ExistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ExistRequest extends ExistEvent {
  final SavedTrain savedTrain;
  final SavedTrainType type;

  ExistRequest({@required this.savedTrain, this.type});

  @override
  List<Object> get props => [savedTrain, type];
}
