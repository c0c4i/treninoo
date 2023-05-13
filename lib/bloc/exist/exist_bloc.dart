import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';

import '../../exceptions/more_than_one.dart';
import '../../repository/saved_train.dart';

class ExistBloc extends Bloc<ExistEvent, ExistState> {
  final TrainRepository _trainRepository;
  final SavedTrainRepository _savedTrainRepository;

  ExistBloc(TrainRepository trainRepository,
      SavedTrainRepository savedTrainRepository)
      : _trainRepository = trainRepository,
        _savedTrainRepository = savedTrainRepository,
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
      _savedTrainRepository.addRecent(SavedTrain.fromTrainInfo(trainInfo));
      yield ExistSuccess(trainInfo: trainInfo);
    } on MoreThanOneException catch (exception) {
      yield ExistMoreThanOne(
        savedTrain: exception.savedTrain,
        stations: exception.stations,
      );
    } catch (e) {
      yield ExistFailed(savedTrain: event.savedTrain, type: event.type);
    }
    yield ExistInitial();
  }
}
