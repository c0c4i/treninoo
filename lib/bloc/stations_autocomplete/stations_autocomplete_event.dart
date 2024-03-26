import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StationsAutocompleteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStationsAutocomplete extends StationsAutocompleteEvent {
  final String text;

  GetStationsAutocomplete({required this.text});

  @override
  List<Object?> get props => [text];
}
