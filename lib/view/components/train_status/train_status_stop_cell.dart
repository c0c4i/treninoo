import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/view/style/colors/accent.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../../cubit/predicted_arrival.dart';

class TrainStatusStopCell extends StatefulWidget {
  const TrainStatusStopCell({
    Key? key,
    required this.cellType,
    this.plannedArrival,
    this.plannedDeparture,
    this.actualArrival,
    this.actualDeparture,
    this.delay,
  }) : super(key: key);

  final CellType cellType;
  final dynamic plannedArrival;
  final dynamic plannedDeparture;
  final dynamic actualArrival;
  final dynamic actualDeparture;
  final int? delay;

  @override
  State<TrainStatusStopCell> createState() => _TrainStatusStopCellState();
}

class _TrainStatusStopCellState extends State<TrainStatusStopCell> {
  selectValue() {
    if (widget.actualArrival != null) return widget.actualArrival;
    if (widget.plannedArrival != null) return widget.plannedArrival;

    if (widget.actualDeparture != null) return widget.actualDeparture;
    if (widget.plannedDeparture != null) return widget.plannedDeparture;

    switch (widget.cellType) {
      case CellType.binary:
        return "-";
      case CellType.time:
        return "—:—";
    }
  }

  get label {
    var value = selectValue();
    if (value is TimeOfDay) {
      if (!confirmed && context.read<PredictedArrivalCubit>().state) {
        // Convert to datetime
        DateTime now = DateTime.now();
        DateTime dateTime = DateTime(
          now.year,
          now.month,
          now.day,
          value.hour,
          value.minute,
        );

        // Add delay
        if (widget.delay != null) {
          dateTime = dateTime.add(
            Duration(minutes: widget.delay!),
          );
        }

        // Convert back to time of day
        value = TimeOfDay.fromDateTime(dateTime);
      }
      return value.format(context);
    }
    return value.toString();
  }

  get confirmed {
    if (widget.actualArrival != null) return true;
    if (widget.actualDeparture != null) return true;
    if (widget.plannedArrival != null) return false;
    if (widget.plannedDeparture != null) return false;
    return false;
  }

  bool get canBePredicted {
    return widget.actualArrival is TimeOfDay ||
        widget.actualDeparture is TimeOfDay ||
        widget.plannedArrival is TimeOfDay ||
        widget.plannedDeparture is TimeOfDay;
  }

  get style {
    Color? color;
    if (!confirmed) {
      if (canBePredicted && context.read<PredictedArrivalCubit>().state)
        color = Accent.light;
      else
        color = Grey.dark;
    }

    return Typo.subheaderLight.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}

enum CellType { binary, time }
