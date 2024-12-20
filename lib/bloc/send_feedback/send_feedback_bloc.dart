import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      emit(SendFeedbackFailed());
    }
    emit(SendFeedbackInitial());
  }
}
