import 'package:treninoo/model/Solutions.dart';
import 'package:equatable/equatable.dart';

abstract class SolutionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SolutionsInitial extends SolutionsState {}

class SolutionsLoading extends SolutionsState {}

class SolutionsSuccess extends SolutionsState {
  final Solutions solutions;

  SolutionsSuccess({required this.solutions});

  @override
  List<Object> get props => [solutions];
}

class SolutionsFailed extends SolutionsState {}
