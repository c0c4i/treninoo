import 'package:flutter_test/flutter_test.dart';
import 'package:treninoo/model/SavedTrain.dart';

void main() {
  test('Check SavedTrain', () {
    SavedTrain train1 = SavedTrain(
      departureStationCode: "S01700",
      trainCode: "S01700",
      description: "test",
    );

    SavedTrain train2 = SavedTrain(
      departureStationCode: "S01700",
      trainCode: "S01700",
    );

    expect(train1, train2);
  });

  test('Check SavedTrain are not to be equal', () {
    SavedTrain train1 = SavedTrain(
      departureStationCode: "S12345",
      trainCode: "S01700",
    );

    SavedTrain train2 = SavedTrain(
      departureStationCode: "S54321",
      trainCode: "S01700",
    );

    expect(train1, isNot(train2));
  });

  test('Remove description of a SavedTrain', () {
    SavedTrain train1 = SavedTrain(
      departureStationCode: "S12345",
      trainCode: "S01700",
      description: "Test",
    );

    train1 = train1.copyWith(description: null);

    expect(train1.description, isNull);
  });
}
