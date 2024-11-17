import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_row.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';

import '../../../cubit/predicted_arrival.dart';

class TrainStatusStopList extends StatefulWidget {
  const TrainStatusStopList({
    Key? key,
    this.stops,
    this.currentStop,
    required this.delay,
  }) : super(key: key);

  final List<Stop>? stops;
  final String? currentStop;
  final int delay;

  @override
  State<TrainStatusStopList> createState() => _TrainStatusStopListState();
}

class _TrainStatusStopListState extends State<TrainStatusStopList> {
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        nodeItemOverlap: true,
        connectorTheme: ConnectorThemeData(
          thickness: 14,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        indicatorBuilder: (context, index) {
          bool confirmed = widget.stops![index].isAtLeastArrived;
          return DotIndicator(
            size: 14,
            color: confirmed ? Colors.white : Grey.darker,
            border: Border.all(
              color: confirmed ? Primary.normal : Grey.normal,
              width: 2.5,
            ),
          );
        },
        connectorBuilder: (context, index, connectorType) {
          Color color = Grey.normal;

          if (index > widget.stops!.length - 1) {
            return SolidLineConnector(color: color);
          }

          bool confirmed = widget.stops![index + 1].isAtLeastArrived;
          color = confirmed ? Primary.normal : Grey.normal;

          return SolidLineConnector(
            color: color,
          );
        },
        contentsBuilder: (context, index) {
          return TrainStatusStopRow(
            stop: widget.stops![index],
            current:
                widget.stops![index].station.stationName == widget.currentStop,
            delay: widget.delay,
            predicted: context.watch<PredictedArrivalCubit>().state,
          );
        },
        itemCount: widget.stops!.length,
      ),
    );
  }
}
