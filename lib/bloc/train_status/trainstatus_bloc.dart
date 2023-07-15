import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/repository/train.dart';

class TrainStatusBloc extends Bloc<TrainStatusEvent, TrainStatusState> {
  final TrainRepository _trainRepository;

  TrainStatusBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(TrainStatusInitial());

  @override
  Stream<TrainStatusState> mapEventToState(
    TrainStatusEvent event,
  ) async* {
    if (event is TrainStatusRequest) {
      yield* _mapTrainStatusRequest(event);
    }
  }

  Stream<TrainStatusState> _mapTrainStatusRequest(
      TrainStatusRequest event) async* {
    yield TrainStatusLoading();
    try {
      final trainInfo = await _trainRepository.getTrainStatus(event.savedTrain);
      yield TrainStatusSuccess(trainInfo: trainInfo);
    } catch (e) {
      yield TrainStatusFailed();
    }
  }
}
