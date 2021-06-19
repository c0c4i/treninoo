import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_cell.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_station_cell.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainStatusStopRow extends StatelessWidget {
  const TrainStatusStopRow({Key key, this.stop, this.current})
      : super(key: key);

  final Stop stop;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TrainStatusStopStationCell(
              stationName: stop.name,
              actualArrival: stop.actualArrivalTime,
              plannedArrival: stop.plannedArrivalTime,
              actualDeparture: stop.actualDepartureTime,
              plannedDeparture: stop.plannedDepartureTime,
              enable: current,
            ),
          ),
          Expanded(
            flex: 1,
            child: TrainStatusStopCell(
              actualArrival: stop.actualArrivalRail,
              actualDeparture: stop.actualDepartureRail,
              plannedArrival: stop.plannedArrivalRail,
              plannedDeparture: stop.plannedDepartureRail,
              cellType: CellType.binary,
            ),
          ),
          Expanded(
            flex: 2,
            child: TrainStatusStopCell(
              actualArrival: stop.actualArrivalTime,
              plannedArrival: stop.plannedArrivalTime,
              cellType: CellType.time,
            ),
          ),
          Expanded(
            flex: 2,
            child: TrainStatusStopCell(
              actualDeparture: stop.actualDepartureTime,
              plannedDeparture: stop.plannedDepartureTime,
              cellType: CellType.time,
            ),
          ),
        ],
      ),
    );
  }

  // stringa con numero binario oppure - (perché le API torna null se non è assegnato il binario)

}

// controllo dei null negli orari che riceve
String getTime(String time, TimeType type, bool remove) {
  // if (index == 1 && type == 1) return '';

  // if (index == max && type == 0) return '';

  if (time == null) return '-:-';

  return time;
}

String pickBinary(String binary) {
  if (binary != null) return binary;
  return '-';
}

enum TimeType {
  departure,
  arrival,
}
