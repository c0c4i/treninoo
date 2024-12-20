import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
          exception.type != DioExceptionType.unknown &&
          exception.response?.statusCode != 404 &&
          exception.type != DioExceptionType.connectionTimeout) {
        FirebaseCrashlytics.instance.recordError(exception, stackTrace);
      }

      emit(TrainStatusFailed());
    }
  }
}
