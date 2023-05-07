import 'package:equatable/equatable.dart';

abstract class SendFeedbackState extends Equatable {
  @override
  List<Object> get props => [];
}

class SendFeedbackInitial extends SendFeedbackState {}

class SendFeedbackLoading extends SendFeedbackState {}

class SendFeedbackSuccess extends SendFeedbackState {}

class SendFeedbackFailed extends SendFeedbackState {}
