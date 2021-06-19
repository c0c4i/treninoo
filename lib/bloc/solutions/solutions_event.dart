import 'package:equatable/equatable.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/SolutionsInfo.dart';

@immutable
abstract class SolutionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SolutionsRequest extends SolutionsEvent {
  final SolutionsInfo solutionsInfo;

  SolutionsRequest({@required this.solutionsInfo});

  @override
  List<Object> get props => [solutionsInfo];
}
