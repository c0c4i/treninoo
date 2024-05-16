import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:treninoo/repository/train.dart';

@immutable
abstract class StationsAutocompleteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStationsAutocomplete extends StationsAutocompleteEvent {
  final String text;
  final SearchStationType type;

  GetStationsAutocomplete({required this.text, required this.type});

  @override
  List<Object?> get props => [text];
}
