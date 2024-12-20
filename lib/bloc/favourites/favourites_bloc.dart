import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';

import '../../repository/saved_train.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final SavedTrainRepository _savedTrainRepository;

  FavouritesBloc(SavedTrainRepository savedTrainRepository)
      : _savedTrainRepository = savedTrainRepository,
        super(FavouritesInitial()) {
    on<FavouritesRequest>(_mapFavouritesRequest);
    on<DeleteFavourite>(_mapDeleteFavouriteRequest);
    on<ReorderFavourites>(_mapReorderFavourites);
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
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(FavouritesFailed());
    }
  }

  Future<void> _mapReorderFavourites(
      ReorderFavourites event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());
    try {
      await _savedTrainRepository.reorderFavourites(
        event.oldIndex,
        event.newIndex,
      );
      final trains = _savedTrainRepository.getFavourites();
      emit(FavouritesSuccess(trains: []));
      emit(FavouritesSuccess(trains: trains));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(FavouritesFailed());
    }
  }
}
