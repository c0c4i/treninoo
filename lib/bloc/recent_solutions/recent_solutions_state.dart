import 'package:equatable/equatable.dart';
import 'package:treninoo/model/SavedSolutionsInfo.dart';

abstract class RecentSolutionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentSolutionsInitial extends RecentSolutionsState {}

class RecentSolutionsLoading extends RecentSolutionsInitial {}

class RecentSolutionsSuccess extends RecentSolutionsInitial {
  final List<SavedSolutionsInfo> savedSolutionsInfo;

  RecentSolutionsSuccess({required this.savedSolutionsInfo});
  @override
  List<Object> get props => [savedSolutionsInfo];
}

class RecentSolutionsFailed extends RecentSolutionsState {}
