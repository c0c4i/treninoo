import 'package:treninoo/model/Station.dart';

class DepartureStation {
  String trainCode;
  Station station;
  String random;

  DepartureStation({
    this.trainCode,
    this.station,
    this.random,
  });

  factory DepartureStation.fromJson(String line) {
    var details = line.split("|");
    var stationName = details[0].split("-")[1].substring(1);

    var other = details[1].split("-");

    var stationCode = other[1];
    var trainCode = other[0];
    var random = other[2];

    Station station =
        new Station(stationName: stationName, stationCode: stationCode);

    return DepartureStation(
      trainCode: trainCode,
      station: station,
      random: random,
    );
  }
}
