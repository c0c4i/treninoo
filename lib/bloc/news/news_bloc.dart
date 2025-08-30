import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/model/TrenitaliaNews.dart';
import 'package:treninoo/repository/train.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final TrainRepository _trainRepository;

  NewsBloc(this._trainRepository) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        TrenitaliaNews news = await _trainRepository.getNews();
        emit(NewsLoaded(news));
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
        emit(NewsError());
      }
    });
  }
}
