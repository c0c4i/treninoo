class Station {
  String stationName;
  String stationCode;

  Station({
    this.stationName,
    this.stationCode,
  });

  Map<String, dynamic> toJson() => {
        'stationName': stationName,
        'stationCode': stationCode,
      };

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationName: json['stationName'],
      stationCode: json['stationCode'],
    );
  }

  Station equals(int stationCode) {
    return (stationCode.toString() == this.stationCode) ? this : null;
  }

  bool operator ==(Object other) {
    Station tmp = other;
    return (tmp.stationCode == stationCode);
  }
}
