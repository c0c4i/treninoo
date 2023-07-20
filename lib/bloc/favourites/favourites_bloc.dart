import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';

import '../../repository/saved_train.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final SavedTrainRepository _savedTrainRepository;

  FavouritesBloc(SavedTrainRepository savedTrainRepository)
      : _savedTrainRepository = savedTrainRepository,
        super(FavouritesInitial()) {
    on<FavouritesRequest>(_mapFavouritesRequest);
    on<DeleteFavourite>(_mapDeleteFavouriteRequest);
  }

  Future<void> _mapFavouritesRequest(
      FavouritesRequest event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());
    try {
      final trains = _savedTrainRepository.getFavourites();

      emit(FavouritesSuccess(trains: trains));
    } catch (e) {
      emit(FavouritesFailed());
    }
  }

  Future<void> _mapDeleteFavouriteRequest(
      DeleteFavourite event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());
    try {
      _savedTrainRepository.removeFavourite(event.savedTrain);
      final trains = _savedTrainRepository.getFavourites();
      emit(FavouritesSuccess(trains: trains));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(FavouritesFailed());
    }
  }
}
