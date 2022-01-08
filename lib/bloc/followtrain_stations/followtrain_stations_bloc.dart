import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/repository/train.dart';

import 'followtrain_stations_event.dart';
import 'followtrain_stations_state.dart';

class FollowTrainStationsBloc
    extends Bloc<FollowTrainStationsEvent, FollowTrainStationsState> {
  final TrainRepository _trainRepository;

  FollowTrainStationsBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(FollowTrainStationsInitial());

  @override
  Stream<FollowTrainStationsState> mapEventToState(
    FollowTrainStationsEvent event,
  ) async* {
    if (event is FollowTrainStationsRequest) {
      yield* _mapFollowTrainStationsRequest(event);
    }
  }

  Stream<FollowTrainStationsState> _mapFollowTrainStationsRequest(
      FollowTrainStationsRequest event) async* {
    yield FollowTrainStationsLoading();
    try {
      final stations =
          await _trainRepository.getFollowTrainStations(event.departureStation);
      if (stations != null) {
        yield FollowTrainStationsSuccess(
          stations: stations,
        );
      } else {
        yield FollowTrainStationsFailed();
      }
    } catch (e) {
      print(e);
      yield FollowTrainStationsFailed();
    }
  }
}
