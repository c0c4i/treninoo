class SavedTrain {
  String trainCode;
  String trainType;
  String departureStationCode;
  String departureStationName;
  String arrivalStationName;
  String departureTime;

  SavedTrain({
    this.trainCode,
    this.trainType,
    this.departureStationCode,
    this.departureStationName,
    this.arrivalStationName,
    this.departureTime,
  });

  Map<String, dynamic> toJson() => {
        'trainCode': trainCode,
        'trainType': trainType,
        'departureStationCode': departureStationCode,
        'departureStationName': departureStationName,
        'arrivalStationName': arrivalStationName,
        'departureTime': departureTime,
      };

  factory SavedTrain.fromJson(Map<String, dynamic> json) {
    return SavedTrain(
      trainCode: json['trainCode'],
      trainType: json['trainType'],
      departureStationCode: json['departureStationCode'],
      departureStationName: json['departureStationName'],
      arrivalStationName: json['arrivalStationName'],
      departureTime: json['departureTime'],
    );
  }

  SavedTrain equals(String trainCode, String departureStationCode) {
    return (trainCode == this.trainCode &&
            departureStationCode == this.departureStationCode)
        ? this
        : null;
  }

  bool operator ==(Object other) {
    SavedTrain tmp = other;
    return (tmp.trainCode == trainCode &&
        tmp.departureStationCode == departureStationCode);
  }
}
