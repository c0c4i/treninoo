import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recent_solutions/recent_solutions.dart';
import 'package:treninoo/model/SavedSolutionsInfo.dart';
import 'package:treninoo/repository/saved_solution.dart';

class RecentSolutionsBloc
    extends Bloc<RecentSolutionsEvent, RecentSolutionsState> {
  final SavedSolutionInfoRepository _savedSolutionInfoRepository;
  RecentSolutionsBloc(SavedSolutionInfoRepository savedSolutionInfoRepository)
      : _savedSolutionInfoRepository = savedSolutionInfoRepository,
        super(RecentSolutionsInitial()) {
    on<RecentSolutionsRequest>(_mapRecentSolutionsRequest);
    on<AddRecentSolution>(_mapAddRecentSolution);
  }

  Future<void> _mapRecentSolutionsRequest(
      RecentSolutionsRequest event, Emitter<RecentSolutionsState> emit) async {
    emit(RecentSolutionsLoading());
    try {
      List<SavedSolutionsInfo> solutions =
          _savedSolutionInfoRepository.getRecentsSolutionsInfo();
      emit(RecentSolutionsSuccess(savedSolutionsInfo: solutions));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(RecentSolutionsFailed());
    }
  }

  Future<void> _mapAddRecentSolution(
      AddRecentSolution event, Emitter<RecentSolutionsState> emit) async {
    emit(RecentSolutionsLoading());
    try {
      _savedSolutionInfoRepository
          .addRecentSolutionAndRemoveOldest(event.solutionsInfo);
      final List<SavedSolutionsInfo> solutions =
          _savedSolutionInfoRepository.getRecentsSolutionsInfo();
      emit(RecentSolutionsSuccess(savedSolutionsInfo: solutions));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(RecentSolutionsFailed());
    }
  }
}
