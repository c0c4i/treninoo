import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SendFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendFeedbackRequest extends SendFeedbackEvent {
  final String feedback;

  SendFeedbackRequest({@required this.feedback});

  @override
  List<Object> get props => [feedback];
}
