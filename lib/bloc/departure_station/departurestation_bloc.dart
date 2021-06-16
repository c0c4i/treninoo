import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/final.dart';

class DepartureStationBloc
    extends Bloc<DepartureStationEvent, DepartureStationState> {
  final TrainRepository _trainRepository;

  DepartureStationBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(DepartureStationInitial());

  @override
  Stream<DepartureStationState> mapEventToState(
    DepartureStationEvent event,
  ) async* {
    if (event is DepartureStationRequest) {
      yield* _mapDepartureStationRequest(event);
    }
  }

  Stream<DepartureStationState> _mapDepartureStationRequest(
      DepartureStationRequest event) async* {
    yield DepartureStationLoading();
    try {
      final departureStations =
          await _trainRepository.getDepartureStation(event.trainCode);
      if (departureStations != null) {
        yield DepartureStationSuccess(departureStations: departureStations);
      } else {
        yield DepartureStationFailed();
      }
    } catch (e) {
      print(e);
      yield DepartureStationFailed();
    }
  }
}
