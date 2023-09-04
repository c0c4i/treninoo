import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/repository/train.dart';

import 'send_feedback_event.dart';
import 'send_feedback_state.dart';

class SendFeedbackBloc extends Bloc<SendFeedbackEvent, SendFeedbackState> {
  final TrainRepository _trainRepository;

  SendFeedbackBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(SendFeedbackInitial()) {
    on<SendFeedbackRequest>(_mapSendFeedbackRequest);
  }

  Future<void> _mapSendFeedbackRequest(
      SendFeedbackRequest event, Emitter<SendFeedbackState> emit) async {
    emit(SendFeedbackLoading());
    await Future.delayed(Duration(seconds: 1));
    try {
      await _trainRepository.sendFeedback(event.feedback, event.email);
      emit(SendFeedbackSuccess());
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(SendFeedbackFailed());
    }
    emit(SendFeedbackInitial());
  }
}
