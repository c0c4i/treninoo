import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/repository/saved_train.dart';

class PredictedArrivalCubit extends Cubit<bool> {
  PredictedArrivalCubit(this._savedTrainRepository)
      : super(_savedTrainRepository.sharedPrefs.predictedArrival);

  final SavedTrainRepository _savedTrainRepository;

  void setValue(bool enable) {
    _savedTrainRepository.sharedPrefs.predictedArrival = enable;
    emit(enable);
  }
}
