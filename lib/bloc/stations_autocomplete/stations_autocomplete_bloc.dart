import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:treninoo/bloc/stations_autocomplete/stations_autocomplete_event.dart';
import 'package:treninoo/bloc/stations_autocomplete/stations_autocomplete_state.dart';
import 'package:treninoo/repository/train.dart';

class StationsAutocompleteBloc
    extends Bloc<StationsAutocompleteEvent, StationsAutocompleteState> {
  final TrainRepository _trainRepository;

  StationsAutocompleteBloc(TrainRepository trainRepository)
      : _trainRepository = trainRepository,
        super(StationsAutocompleteInitial()) {
    on<GetStationsAutocomplete>(_mapStationsAutocompleteRequest);
  }

  Future<void> _mapStationsAutocompleteRequest(GetStationsAutocomplete event,
      Emitter<StationsAutocompleteState> emit) async {
    emit(StationsAutocompleteLoading());
    try {
      if (event.text.isEmpty) {
        emit(StationsAutocompleteSuccess(stations: []));
        return;
      }

      final stations = await _trainRepository.searchStations(
        event.text,
        SearchStationType.LEFRECCE,
      );

      emit(StationsAutocompleteSuccess(stations: stations));
    } catch (e) {
      emit(StationsAutocompleteFailed());
    }
  }
}
