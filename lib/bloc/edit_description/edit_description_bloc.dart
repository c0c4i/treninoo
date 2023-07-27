import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../repository/saved_train.dart';
import 'edit_description_event.dart';
import 'edit_description_state.dart';

class EditDescriptionBloc
    extends Bloc<EditDescriptionEvent, EditDescriptionState> {
  final SavedTrainRepository _savedSavedTrainRepository;

  EditDescriptionBloc(SavedTrainRepository savedSavedTrainRepository)
      : _savedSavedTrainRepository = savedSavedTrainRepository,
        super(EditDescriptionInitial()) {
    on<EditDescriptionRequest>(_mapEditDescriptionRequest);
  }

  Future<void> _mapEditDescriptionRequest(
      EditDescriptionRequest event, Emitter<EditDescriptionState> emit) async {
    emit(EditDescriptionLoading());
    try {
      _savedSavedTrainRepository.changeDescription(event.savedTrain);
      emit(EditDescriptionSuccess());
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(EditDescriptionFailed());
    }
    emit(EditDescriptionInitial());
  }
}
