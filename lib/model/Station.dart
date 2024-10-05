import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Station extends Equatable {
  final String stationName;
  final String stationCode;
  final DateTime departureDate;

  Station({
    required this.stationName,
    required this.stationCode,
    DateTime? departureDate,
  }) : departureDate = departureDate ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'stationName': stationName,
        'stationCode': stationCode,
      };

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationName: json['stationName'],
      stationCode: json['stationCode'].toString(),
      departureDate: json['departureDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['departureDate'])
          : null,
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

  String get departureDateFormatted {
    return DateFormat('dd/MM/yyyy').format(departureDate);
  }

  @override
  List<Object?> get props {
    return [stationCode];
  }
}
