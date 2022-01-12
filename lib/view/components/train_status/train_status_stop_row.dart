import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_cell.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_station_cell.dart';

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
}
