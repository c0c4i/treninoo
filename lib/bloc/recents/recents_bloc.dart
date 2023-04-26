import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final TrainRepository _trainRepository;

  RecentsBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
        super(RecentsInitial());

  @override
  Stream<RecentsState> mapEventToState(
    RecentsEvent event,
  ) async* {
    if (event is RecentsRequest) {
      yield* _mapRecentsRequest(event);
    }

    if (event is DeleteRecent) {
      yield* _mapDeleteRecentRequest(event);
    }
  }

  Stream<RecentsState> _mapRecentsRequest(RecentsRequest event) async* {
    yield RecentsLoading();
    try {
      final trains = getSavedTrain(SavedTrainType.recents);
      if (trains != null) {
        yield RecentsSuccess(trains: trains);
      } else {
        yield RecentsFailed();
      }
    } catch (e) {
      print(e);
      yield RecentsFailed();
    }
  }

  Stream<RecentsState> _mapDeleteRecentRequest(DeleteRecent event) async* {
    yield RecentsLoading();
    try {
      removeTrain(event.savedTrain, SavedTrainType.recents);
      final trains = getSavedTrain(SavedTrainType.recents);
      if (trains != null) {
        yield RecentsSuccess(trains: trains);
      } else {
        yield RecentsFailed();
      }
    } catch (e) {
      print(e);
      yield RecentsFailed();
    }
  }
}
