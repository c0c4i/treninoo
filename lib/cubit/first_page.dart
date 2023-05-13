import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/repository/saved_train.dart';

class FirstPageCubit extends Cubit<int> {
  FirstPageCubit(this._savedTrainRepository)
      : super(_savedTrainRepository.sharedPrefs.firstPage);

  final SavedTrainRepository _savedTrainRepository;

  void changePage(int page) {
    _savedTrainRepository.sharedPrefs.firstPage = page;
    emit(page);
  }
}
