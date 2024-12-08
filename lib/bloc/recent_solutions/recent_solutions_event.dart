import 'package:equatable/equatable.dart';
import 'package:treninoo/model/SolutionsInfo.dart';

abstract class RecentSolutionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentSolutionsRequest extends RecentSolutionsEvent {}

class AddRecentSolution extends RecentSolutionsEvent {
  final SolutionsInfo solutionsInfo;
  AddRecentSolution({required this.solutionsInfo});

  @override
  List<Object> get props => [solutionsInfo];
}
