import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/repository/train.dart';

import 'send_feedback_event.dart';
import 'send_feedback_state.dart';

class SendFeedbackBloc extends Bloc<SendFeedbackEvent, SendFeedbackState> {
  final TrainRepository _trainRepository;

  SendFeedbackBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(SendFeedbackInitial());

  @override
  Stream<SendFeedbackState> mapEventToState(
    SendFeedbackEvent event,
  ) async* {
    if (event is SendFeedbackRequest) {
      yield* _mapSendFeedbackRequest(event);
    }
  }

  Stream<SendFeedbackState> _mapSendFeedbackRequest(
      SendFeedbackRequest event) async* {
    yield SendFeedbackLoading();
    await Future.delayed(Duration(seconds: 1));
    try {
      await _trainRepository.sendFeedback(event.feedback);
      yield SendFeedbackSuccess();
    } catch (e) {
      yield SendFeedbackFailed();
    }
    yield SendFeedbackInitial();
  }
}
