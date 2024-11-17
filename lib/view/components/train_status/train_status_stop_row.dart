import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_station_cell.dart';
import 'package:treninoo/view/style/theme.dart';
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

  get arrivalColor {
    if (stop.confirmed || stop.currentStation) return null;

    if (stop.actualArrivalTime == null &&
        stop.plannedArrivalTime == null &&
        stop.predictedArrivalTime == null) return null;

    if (predicted) return Accent.normal;

    return Grey.dark;
  }

  get departureColor {
    if (stop.confirmed) return null;

    if (stop.actualDepartureTime == null &&
        stop.plannedDepartureTime == null &&
        stop.predictedDepartureTime == null) return null;

    if (predicted) return Accent.normal;
    return Grey.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Semantics(
              excludeSemantics: true,
              label: "Stazione: ${stop.station.stationName}.",
              child: TrainStatusStopStationCell(
                stationName: stop.station.stationName,
                current: current,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Semantics(
              excludeSemantics: true,
              label:
                  "Binario ${stop.confirmedBinary ? "effettivo" : "previsto"} ${stop.binary}.",
              child: Text(
                stop.binary,
                style: Typo.subheaderLight.copyWith(
                  color: !stop.confirmedBinary ? Colors.grey : null,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Semantics(
              label:
                  "Arrivo ${stop.actualArrivalTime != null ? 'effettivo' : 'previsto'} ${stop.selectTime(context, stop.actualArrivalTime, stop.plannedArrivalTime, stop.predictedArrivalTime, predicted)}.",
              excludeSemantics: true,
              child: Column(
                children: [
                  Text(
                    stop.plannedArrivalTime?.format(context) ?? Stop.emptyTime,
                    style: Typo.subheaderLight.copyWith(
                      color: Grey.dark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (stop.confirmed || predicted)
                    Text(
                      stop.selectTime(
                        context,
                        stop.actualArrivalTime,
                        stop.plannedArrivalTime,
                        stop.predictedArrivalTime,
                        predicted,
                      ),
                      style: Typo.subheaderLight.copyWith(
                        color: arrivalColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Semantics(
              label:
                  "Partenza ${stop.actualDepartureTime != null ? 'effettiva' : 'prevista'} ${stop.selectTime(context, stop.actualDepartureTime, stop.plannedDepartureTime, stop.predictedDepartureTime, predicted)}.",
              excludeSemantics: true,
              child: Column(
                children: [
                  Text(
                    stop.plannedDepartureTime?.format(context) ??
                        Stop.emptyTime,
                    style: Typo.subheaderLight.copyWith(
                      color: Grey.dark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Confirmed or predicted enabled
                  if (stop.confirmed || predicted)
                    Text(
                      stop.selectTime(
                        context,
                        stop.actualDepartureTime,
                        stop.plannedDepartureTime,
                        stop.predictedDepartureTime,
                        predicted,
                      ),
                      style: Typo.subheaderLight.copyWith(
                        color: departureColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
