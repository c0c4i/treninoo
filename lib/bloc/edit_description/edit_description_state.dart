import 'package:equatable/equatable.dart';

abstract class EditDescriptionState extends Equatable {
  @override
  List<Object> get props => [];
}

class EditDescriptionInitial extends EditDescriptionState {}

class EditDescriptionLoading extends EditDescriptionState {}

class EditDescriptionSuccess extends EditDescriptionState {}

class EditDescriptionFailed extends EditDescriptionState {}
