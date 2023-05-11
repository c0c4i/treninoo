import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/repository/train.dart';

class SolutionsBloc extends Bloc<SolutionsEvent, SolutionsState> {
  final TrainRepository _trainRepository;

  SolutionsBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(SolutionsInitial());

  @override
  Stream<SolutionsState> mapEventToState(
    SolutionsEvent event,
  ) async* {
    if (event is SolutionsRequest) {
      yield* _mapSolutionsRequest(event);
    }
  }

  Stream<SolutionsState> _mapSolutionsRequest(SolutionsRequest event) async* {
    yield SolutionsLoading();
    try {
      final solutions =
          await _trainRepository.getSolutions(event.solutionsInfo);
      _trainRepository.addRecentStation(event.solutionsInfo.departureStation);
      _trainRepository.addRecentStation(event.solutionsInfo.arrivalStation);
      if (solutions != null) {
        yield SolutionsSuccess(solutions: solutions);
      } else {
        yield SolutionsFailed();
      }
    } catch (e) {
      print(e);
      yield SolutionsFailed();
    }
  }
}
