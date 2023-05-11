import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/repository/train.dart';

import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final TrainRepository _trainRepository;

  FavouriteBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    if (event is FavouriteRequest) {
      yield* _mapFavouriteRequest(event);
    }

    if (event is FavouriteToggle) {
      yield* _mapFavouriteToggle(event);
    }
  }

  Stream<FavouriteState> _mapFavouriteRequest(FavouriteRequest event) async* {
    yield FavouriteLoading();
    await Future.delayed(Duration(seconds: 1));
    try {
      bool isFavourite = _trainRepository.isFavourite(event.savedTrain);
      yield FavouriteSuccess(isFavourite: isFavourite);
    } catch (e) {
      yield FavouriteFailed();
    }
  }

  Stream<FavouriteState> _mapFavouriteToggle(FavouriteToggle event) async* {
    yield FavouriteLoading();
    await Future.delayed(Duration(seconds: 1));
    try {
      event.value
          ? _trainRepository.saveTrain(
              event.savedTrain,
              SavedTrainType.favourites,
            )
          : _trainRepository.removeTrain(
              event.savedTrain,
              SavedTrainType.favourites,
            );
      yield FavouriteSuccess(isFavourite: event.value);
    } catch (e) {
      yield FavouriteFailed();
    }
  }
}
