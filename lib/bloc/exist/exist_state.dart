import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ExistState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExistInitial extends ExistState {}

class ExistLoading extends ExistState {}

class ExistSuccess extends ExistState {
  final bool exist;

  ExistSuccess({@required this.exist});

  @override
  List<Object> get props => [exist];
}

class ExistFailed extends ExistState {}
