import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/repository/train.dart';

import 'edit_description_event.dart';
import 'edit_description_state.dart';

class EditDescriptionBloc
    extends Bloc<EditDescriptionEvent, EditDescriptionState> {
  final TrainRepository _trainRepository;

  EditDescriptionBloc(TrainRepository trainRepository)
      : assert(trainRepository != null),
        _trainRepository = trainRepository,
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
      _trainRepository.changeDescription(event.savedTrain);
      yield EditDescriptionSuccess();
    } catch (e) {
      print(e);
      yield EditDescriptionFailed();
    }
    yield EditDescriptionInitial();
  }
}
