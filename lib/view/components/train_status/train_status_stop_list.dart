import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_row.dart';

import '../../../cubit/predicted_arrival.dart';

class TrainStatusStopList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: stops!.length,
      itemBuilder: (context, index) {
        return TrainStatusStopRow(
          stop: stops![index],
          current: stops![index].station.stationName == currentStop,
          delay: delay,
          predicted: context.watch<PredictedArrivalCubit>().state,
        );
      },
    );
  }
}
