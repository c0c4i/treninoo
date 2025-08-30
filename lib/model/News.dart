import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String title;
  final DateTime? date;
  final String? content;

  News({
    required this.title,
    this.date,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      content: json['content'],
    );
  }

  @override
  List<Object?> get props => [title];
}
