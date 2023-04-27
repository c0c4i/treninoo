import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/repository/train.dart';

import '../../utils/shared_preference_methods.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final TrainRepository _trainRepository;

  FavouritesBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(FavouritesInitial());

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is FavouritesRequest) {
      yield* _mapFavouritesRequest(event);
    }
    if (event is DeleteFavourite) {
      yield* _mapDeleteFavouriteRequest(event);
    }
  }

  Stream<FavouritesState> _mapFavouritesRequest(
      FavouritesRequest event) async* {
    yield FavouritesLoading();
    try {
      final trains = _trainRepository.getSavedTrain(SavedTrainType.favourites);
      if (trains != null) {
        yield FavouritesSuccess(trains: trains);
      } else {
        yield FavouritesFailed();
      }
    } catch (e) {
      print(e);
      yield FavouritesFailed();
    }
  }

  Stream<FavouritesState> _mapDeleteFavouriteRequest(
      DeleteFavourite event) async* {
    yield FavouritesLoading();
    try {
      removeTrain(event.savedTrain, SavedTrainType.favourites);
      final trains = _trainRepository.getSavedTrain(SavedTrainType.favourites);
      if (trains != null) {
        yield FavouritesSuccess(trains: trains);
      } else {
        yield FavouritesFailed();
      }
    } catch (e) {
      print(e);
      yield FavouritesFailed();
    }
  }
}
