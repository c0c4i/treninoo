import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/repository/train.dart';

import 'followtrain_stations_event.dart';
import 'followtrain_stations_state.dart';

class FollowTrainStationsBloc
    extends Bloc<FollowTrainStationsEvent, FollowTrainStationsState> {
  final TrainRepository _trainRepository;

  FollowTrainStationsBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(FollowTrainStationsInitial()) {
    on<FollowTrainStationsRequest>(_mapFollowTrainStationsRequest);
  }

  Future<void> _mapFollowTrainStationsRequest(FollowTrainStationsRequest event,
      Emitter<FollowTrainStationsState> emit) async {
    emit(FollowTrainStationsLoading());
    try {
      final stations =
          await _trainRepository.getFollowTrainStations(event.savedTrain);
      emit(FollowTrainStationsSuccess(stations: stations));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(FollowTrainStationsFailed());
    }
  }
}
