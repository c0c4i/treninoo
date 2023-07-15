import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../repository/saved_train.dart';
import 'edit_description_event.dart';
import 'edit_description_state.dart';

class EditDescriptionBloc
    extends Bloc<EditDescriptionEvent, EditDescriptionState> {
  final SavedTrainRepository _savedSavedTrainRepository;

  EditDescriptionBloc(SavedTrainRepository savedSavedTrainRepository)
      : _savedSavedTrainRepository = savedSavedTrainRepository,
        super(EditDescriptionInitial());

  @override
  Stream<EditDescriptionState> mapEventToState(
    EditDescriptionEvent event,
  ) async* {
    if (event is EditDescriptionRequest) {
      yield* _mapEditDescriptionRequest(event);
    }
  }

  Stream<EditDescriptionState> _mapEditDescriptionRequest(
      EditDescriptionRequest event) async* {
    yield EditDescriptionLoading();
    try {
      _savedSavedTrainRepository.changeDescription(event.savedTrain);
      yield EditDescriptionSuccess();
    } catch (e) {
      print(e);
      yield EditDescriptionFailed();
    }
    yield EditDescriptionInitial();
  }
}
