import 'package:treninoo/model/SavedTrain.dart';

import '../model/Station.dart';

class MoreThanOneException implements Exception {
  SavedTrain? savedTrain;
  final List<Station> stations;

  MoreThanOneException(this.savedTrain, this.stations);
}
