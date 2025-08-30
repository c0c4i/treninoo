import 'package:equatable/equatable.dart';
import 'package:treninoo/model/News.dart';
import 'package:treninoo/model/Strike.dart';

class TrenitaliaNews extends Equatable {
  final List<News> newsInfomobilita;
  final List<News> newsModificheProgrammate;
  final List<Strike> strikes;

  TrenitaliaNews({
    required this.newsInfomobilita,
    required this.newsModificheProgrammate,
    required this.strikes,
  });

  factory TrenitaliaNews.fromJson(Map<String, dynamic> json) {
    return TrenitaliaNews(
      newsInfomobilita: (json['newsInfomobilita'] as List)
          .map((news) => News.fromJson(news))
          .toList(),
      newsModificheProgrammate: (json['newsModificheProgrammate'] as List)
          .map((news) => News.fromJson(news))
          .toList(),
      strikes: (json['strikes'] as List?)
              ?.map((strike) => Strike.fromJson(strike))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
        newsInfomobilita,
        newsModificheProgrammate,
        strikes,
      ];
}
