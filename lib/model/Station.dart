import 'package:equatable/equatable.dart';

class Station extends Equatable {
  final String stationName;
  final String stationCode;

  Station({
    required this.stationName,
    required this.stationCode,
  });

  Map<String, dynamic> toJson() => {
        'stationName': stationName,
        'stationCode': stationCode,
      };

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationName: json['stationName'],
      stationCode: json['stationCode'].toString(),
    );
  }

  Station? equals(int stationCode) {
    return (stationCode.toString() == this.stationCode) ? this : null;
  }

  static Station fakeItaloStation() {
    return Station(
      stationName: "Italo",
      stationCode: "italo",
    );
  }

  @override
  List<Object?> get props {
    return [stationCode];
  }
}
