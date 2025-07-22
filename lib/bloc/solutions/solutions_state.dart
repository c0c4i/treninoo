import 'package:treninoo/model/Solutions.dart';
import 'package:equatable/equatable.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';

abstract class SolutionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SolutionsInitial extends SolutionsState {}

class SolutionsLoading extends SolutionsState {}

class SolutionsSuccess extends SolutionsState {
  final SolutionsInfo solutionsInfo;
  final Solutions solutions;
  final Map<TrainSolution, TrainInfo> trainInfos;

  SolutionsSuccess({
    required this.solutionsInfo,
    required this.solutions,
    this.trainInfos = const {},
  });

  @override
  List<Object> get props => [solutionsInfo, solutions, trainInfos];
}

class SolutionsFailed extends SolutionsState {}
