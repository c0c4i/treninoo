import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/recents/recents.dart';

import '../../repository/saved_train.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final SavedTrainRepository _savedTrainRepository;

  RecentsBloc(SavedTrainRepository savedTrainRepository)
      : _savedTrainRepository = savedTrainRepository,
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
      final trains = _savedTrainRepository.getRecents();
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
      _savedTrainRepository.removeRecent(event.savedTrain);
      final trains = _savedTrainRepository.getRecents();
      yield RecentsSuccess(trains: trains);
    } catch (e) {
      yield RecentsFailed();
    }
  }
}
