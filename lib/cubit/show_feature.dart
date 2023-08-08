import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/repository/saved_train.dart';

class ShowFeatureCubit extends Cubit<bool> {
  ShowFeatureCubit(this._savedTrainRepository)
      : super(_savedTrainRepository.sharedPrefs.showFeature);

  final SavedTrainRepository _savedTrainRepository;

  void update(bool value) {
    _savedTrainRepository.sharedPrefs.showFeature = value;
    emit(value);
  }
}
