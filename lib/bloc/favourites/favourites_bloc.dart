import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';

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
  }

  Stream<FavouritesState> _mapFavouritesRequest(
      FavouritesRequest event) async* {
    yield FavouritesLoading();
    try {
      final trains = getSavedTrain(SavedTrainType.favourites);
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
