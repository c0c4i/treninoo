import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainInfoBinaries.dart';

class TrainSolution extends Equatable {
  final String origin;
  final String? destination;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? trainType;
  final String? trainCode;
  final Station? originStation;
  final Station? destinationStation;

  TrainSolution({
    this.trainCode,
    required this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.trainType,
    this.originStation,
    this.destinationStation,
  });

  factory TrainSolution.fromJson(Map<String, dynamic> json) {
    Station? originStation = json['originStation'] != null
        ? Station.fromJson(json['originStation'])
        : null;

    Station? destinationStation = json['destinationStation'] != null
        ? Station.fromJson(json['destinationStation'])
        : null;

    return TrainSolution(
      origin: json['origin'],
      destination: json['destination'],
      departureTime: DateTime.parse(json['departureTime']),
      arrivalTime: DateTime.parse(json['arrivalTime']),
      trainType: json['category'],
      trainCode: json['trainCode'],
      originStation: originStation,
      destinationStation: destinationStation,
    );
  }

  TrainInfoRails getRails(TrainInfo trainInfo) {
    if (originStation == null && destinationStation == null) {
      return TrainInfoRails();
    }

    if (trainInfo.stops == null) return TrainInfoRails();

    TrainInfoRails trainInfoRails = TrainInfoRails();

    String? originCode = originStation?.stationCode;
    String? destinationCode = destinationStation?.stationCode;

    for (var stop in trainInfo.stops!) {
      String stationCode = stop.station.stationCode;

      if (originStation != null && stationCode == originCode) {
        trainInfoRails = trainInfoRails.copyWith(
          originRail: stop.binary,
          originRailConfirmed: stop.confirmedBinary,
        );
      }

      if (destinationCode != null && stationCode == destinationCode) {
        trainInfoRails = trainInfoRails.copyWith(
          destinationRail: stop.binary,
          destinationRailConfirmed: stop.confirmedBinary,
        );
      }
    }
    if (trainInfoRails.originRail == null ||
        trainInfoRails.destinationRail == null) {
      FirebaseCrashlytics.instance.recordError(
        'Matched stop not found',
        StackTrace.current,
        reason:
            'Train: ${trainInfo.trainCode}, origin: $origin, destination: $destination',
        information: [trainInfo.trainCode, trainInfo.departureStation.toJson()],
      );
    }

    return trainInfoRails;
  }

  @override
  List<Object?> get props => [trainCode, origin];
}
