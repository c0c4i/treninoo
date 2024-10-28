import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../repository/saved_train.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final SavedTrainRepository _savedSavedTrainRepository;

  FavouriteBloc(SavedTrainRepository savedSavedTrainRepository)
      : _savedSavedTrainRepository = savedSavedTrainRepository,
        super(FavouriteInitial()) {
    on<FavouriteRequest>(_mapFavouriteRequest);
    on<FavouriteToggle>(_mapFavouriteToggle);
  }

  Future<void> _mapFavouriteRequest(
      FavouriteRequest event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    await Future.delayed(Duration(milliseconds: 500));
    try {
      bool isFavourite =
          _savedSavedTrainRepository.isFavourite(event.savedTrain);
      emit(FavouriteSuccess(isFavourite: isFavourite));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(FavouriteFailed());
    }
  }

  Future<void> _mapFavouriteToggle(
      FavouriteToggle event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoading());
    await Future.delayed(Duration(milliseconds: 500));
    try {
      event.value
          ? _savedSavedTrainRepository.addFavourite(event.savedTrain)
          : _savedSavedTrainRepository.removeFavourite(event.savedTrain);
      emit(FavouriteSuccess(isFavourite: event.value));
    } catch (exception, stackTrace) {
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(FavouriteFailed());
    }
  }
}
