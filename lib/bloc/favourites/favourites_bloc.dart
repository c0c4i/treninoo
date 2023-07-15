import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';

import '../../repository/saved_train.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final SavedTrainRepository _savedTrainRepository;

  FavouritesBloc(SavedTrainRepository savedTrainRepository)
      : _savedTrainRepository = savedTrainRepository,
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
      final trains = _savedTrainRepository.getFavourites();
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
      _savedTrainRepository.removeFavourite(event.savedTrain);
      final trains = _savedTrainRepository.getFavourites();
      yield FavouritesSuccess(trains: trains);
    } catch (e) {
      print(e);
      yield FavouritesFailed();
    }
  }
}
