import 'package:equatable/equatable.dart';

class TrainInfoRails extends Equatable {
  final String? originRail;
  final bool originRailConfirmed;
  final String? destinationRail;
  final bool destinationRailConfirmed;

  TrainInfoRails({
    this.originRail,
    this.originRailConfirmed = false,
    this.destinationRail,
    this.destinationRailConfirmed = false,
  });

  TrainInfoRails copyWith({
    String? originRail,
    bool? originRailConfirmed,
    String? destinationRail,
    bool? destinationRailConfirmed,
  }) {
    return TrainInfoRails(
      originRail: originRail ?? this.originRail,
      originRailConfirmed: originRailConfirmed ?? this.originRailConfirmed,
      destinationRail: destinationRail ?? this.destinationRail,
      destinationRailConfirmed:
          destinationRailConfirmed ?? this.destinationRailConfirmed,
    );
  }

  @override
  List<Object?> get props => [
        originRail,
        originRailConfirmed,
        destinationRail,
        destinationRailConfirmed,
      ];
}
