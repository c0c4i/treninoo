import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../repository/saved_train.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final SavedTrainRepository _savedSavedTrainRepository;

  FavouriteBloc(SavedTrainRepository savedSavedTrainRepository)
      : assert(savedSavedTrainRepository != null),
        _savedSavedTrainRepository = savedSavedTrainRepository,
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
    await Future.delayed(Duration(milliseconds: 500));
    try {
      bool isFavourite =
          _savedSavedTrainRepository.isFavourite(event.savedTrain);
      yield FavouriteSuccess(isFavourite: isFavourite);
    } catch (e) {
      yield FavouriteFailed();
    }
  }

  Stream<FavouriteState> _mapFavouriteToggle(FavouriteToggle event) async* {
    yield FavouriteLoading();
    await Future.delayed(Duration(milliseconds: 500));
    try {
      event.value
          ? _savedSavedTrainRepository.addFavourite(event.savedTrain)
          : _savedSavedTrainRepository.removeFavourite(event.savedTrain);
      yield FavouriteSuccess(isFavourite: event.value);
    } catch (e) {
      yield FavouriteFailed();
    }
  }
}
