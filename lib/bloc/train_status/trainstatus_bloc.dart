import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/repository/train.dart';

class TrainStatusBloc extends Bloc<TrainStatusEvent, TrainStatusState> {
  final TrainRepository _trainRepository;

  TrainStatusBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(TrainStatusInitial()) {
    on<TrainStatusRequest>(_mapTrainStatusRequest);
  }

  Future<void> _mapTrainStatusRequest(
      TrainStatusRequest event, Emitter<TrainStatusState> emit) async {
    emit(TrainStatusLoading());
    try {
      final trainInfo = await _trainRepository.getTrainStatus(event.savedTrain);
      emit(TrainStatusSuccess(trainInfo: trainInfo));
    } catch (exception, stackTrace) {
      if (exception is DioException &&
          exception.message != null &&
          exception.type != DioExceptionType.unknown) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
      }

      emit(TrainStatusFailed());
    }
  }
}
