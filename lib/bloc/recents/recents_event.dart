import 'package:equatable/equatable.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecentsRequest extends RecentsEvent {}
