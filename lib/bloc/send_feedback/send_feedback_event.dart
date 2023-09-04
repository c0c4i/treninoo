import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SendFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendFeedbackRequest extends SendFeedbackEvent {
  final String feedback;
  final String? email;

  SendFeedbackRequest({
    required this.feedback,
    this.email,
  });

  @override
  List<Object> get props => [feedback];
}
