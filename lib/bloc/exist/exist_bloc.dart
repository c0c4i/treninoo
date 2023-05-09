import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/repository/train.dart';

class ExistBloc extends Bloc<ExistEvent, ExistState> {
  final TrainRepository _trainRepository;

  ExistBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(ExistInitial());

  @override
  Stream<ExistState> mapEventToState(
    ExistEvent event,
  ) async* {
    if (event is ExistRequest) {
      yield* _mapExistRequest(event);
    }
  }

  Stream<ExistState> _mapExistRequest(ExistRequest event) async* {
    yield ExistLoading();
    try {
      final trainInfo = await _trainRepository.getTrainStatus(event.savedTrain);
      yield ExistSuccess(trainInfo: trainInfo);
    } catch (e) {
      yield ExistFailed(savedTrain: event.savedTrain, type: event.type);
    }
    yield ExistInitial();
  }
}
