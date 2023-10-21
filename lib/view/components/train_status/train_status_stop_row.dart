import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_station_cell.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../style/colors/accent.dart';
import '../../style/colors/grey.dart';

class TrainStatusStopRow extends StatelessWidget {
  const TrainStatusStopRow({
    Key? key,
    required this.stop,
    required this.current,
    required this.delay,
    required this.predicted,
  }) : super(key: key);

  final Stop stop;
  final bool current;
  final int delay;
  final bool predicted;

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
              stationName: stop.station.stationName,
              current: current,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              stop.binary,
              style: Typo.subheaderLight.copyWith(
                color: !stop.confirmedBinary ? Colors.grey : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              stop.selectTime(
                context,
                stop.actualArrivalTime,
                stop.plannedArrivalTime,
                stop.predictedArrivalTime,
                predicted,
              ),
              style: Typo.subheaderLight.copyWith(
                color: !stop.confirmed && !stop.currentStation
                    ? (predicted ? Accent.normal : Grey.dark)
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              stop.selectTime(
                context,
                stop.actualDepartureTime,
                stop.plannedDepartureTime,
                stop.predictedDepartureTime,
                predicted,
              ),
              style: Typo.subheaderLight.copyWith(
                color: !stop.confirmed
                    ? (predicted ? Accent.normal : Grey.dark)
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
