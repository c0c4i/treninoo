import 'package:equatable/equatable.dart';
import 'package:treninoo/model/Station.dart';

abstract class StationsAutocompleteState extends Equatable {
  @override
  List<Object> get props => [];
}

class StationsAutocompleteInitial extends StationsAutocompleteState {}

class StationsAutocompleteLoading extends StationsAutocompleteState {}

class StationsAutocompleteSuccess extends StationsAutocompleteState {
  final List<Station> stations;

  StationsAutocompleteSuccess({required this.stations});

  @override
  List<Object> get props => [stations];
}

class StationsAutocompleteFailed extends StationsAutocompleteState {}
