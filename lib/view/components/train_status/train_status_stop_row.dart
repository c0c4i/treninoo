import 'package:flutter/material.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_station_cell.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../style/colors/accent.dart';
import '../../style/colors/grey.dart';

class TrainStatusStopRow extends StatefulWidget {
  const TrainStatusStopRow({
    Key? key,
    required this.stop,
    required this.current,
    required this.delay,
    required this.predicted,
    required this.isDeparted,
  }) : super(key: key);

  final Stop stop;
  final bool current;
  final int delay;
  final bool predicted;
  final bool isDeparted;

  @override
  State<TrainStatusStopRow> createState() => _TrainStatusStopRowState();
}

class _TrainStatusStopRowState extends State<TrainStatusStopRow> {
  get arrivalColor {
    if (widget.stop.confirmed || widget.stop.currentStation) return null;

    if (widget.stop.actualArrivalTime == null &&
        widget.stop.plannedArrivalTime == null &&
        widget.stop.predictedArrivalTime == null) return null;

    if (widget.predicted) return predictedColor;

    return Grey.dark;
  }

  get departureColor {
    if (widget.stop.confirmed) return null;

    if (widget.stop.actualDepartureTime == null &&
        widget.stop.plannedDepartureTime == null &&
        widget.stop.predictedDepartureTime == null) return null;

    if (widget.predicted) return predictedColor;

    return Grey.dark;
  }

  get predictedColor {
    return AppTheme.isDarkMode(context)
        ? Color.lerp(Accent.normal, Colors.white, 0.4)
        : Accent.normal;
  }

  get binarySemantics {
    if (widget.stop.binary == '-') return null;

    return widget.stop.suppressed
        ? null
        : "Binario ${widget.stop.confirmedBinary ? "effettivo" : "previsto"} ${widget.stop.binary}.";
  }

  get arrivalSemantics {
    if (widget.stop.suppressed) return null;

    String time = widget.stop.selectTime(
      context,
      widget.stop.actualArrivalTime,
      widget.stop.plannedArrivalTime,
      widget.stop.predictedArrivalTime,
      widget.predicted,
    );

    if (time == Stop.emptyTime) return null;

    return "Arrivo ${widget.stop.actualArrivalTime != null ? 'effettivo' : 'previsto'} $time.";
  }

  get departureSemantics {
    if (widget.stop.suppressed) return null;

    String time = widget.stop.selectTime(
      context,
      widget.stop.actualDepartureTime,
      widget.stop.plannedDepartureTime,
      widget.stop.predictedDepartureTime,
      widget.predicted,
    );

    if (time == Stop.emptyTime) return null;

    return "Partenza ${widget.stop.actualDepartureTime != null ? 'effettiva' : 'prevista'} $time.";
  }

  bool get showSecondTime {
    if (!widget.isDeparted) return false;
    return widget.stop.confirmed || widget.predicted;
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
              label: "Stazione: ${widget.stop.station.stationName}." +
                  (widget.stop.suppressed ? " Stazione soppressa." : ""),
              button: widget.stop.suppressed ? false : true,
              child: TrainStatusStopStationCell(
                station: widget.stop.station,
                suppressed: widget.stop.suppressed,
                current: widget.current,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Semantics(
              excludeSemantics: true,
              label: binarySemantics,
              child: Text(
                widget.stop.binary,
                style: Typo.subheaderLight.copyWith(
                  color: !widget.stop.confirmedBinary ? Colors.grey : null,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Semantics(
              label: arrivalSemantics,
              excludeSemantics: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.stop.plannedArrivalTime?.format(context) ??
                        Stop.emptyTime,
                    style: Typo.subheaderLight.copyWith(
                      color: Grey.dark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (showSecondTime)
                    Text(
                      widget.stop.selectTime(
                        context,
                        widget.stop.actualArrivalTime,
                        widget.stop.plannedArrivalTime,
                        widget.stop.predictedArrivalTime,
                        widget.predicted,
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
              label: departureSemantics,
              excludeSemantics: true,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: !showSecondTime ? kPadding / 2 : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.stop.plannedDepartureTime?.format(context) ??
                          Stop.emptyTime,
                      style: Typo.subheaderLight.copyWith(
                        color: Grey.dark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (showSecondTime)
                      Text(
                        widget.stop.selectTime(
                          context,
                          widget.stop.actualDepartureTime,
                          widget.stop.plannedDepartureTime,
                          widget.stop.predictedDepartureTime,
                          widget.predicted,
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
          ),
        ],
      ),
    );
  }
}
