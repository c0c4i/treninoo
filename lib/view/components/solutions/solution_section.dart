import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/view/components/solutions/solution_section_header.dart';
import 'package:treninoo/view/components/solutions/solution_section_stations.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../../bloc/exist/exist.dart';

class SolutionSection extends StatelessWidget {
  final TrainSolution trainSolution;
  final int? position;
  final int? size;

  const SolutionSection(
      {Key? key, required this.trainSolution, this.position, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: trainSolution.trainCode != null
          ? () {
              SavedTrain savedTrain = new SavedTrain(
                trainCode: trainSolution.trainCode!,
                departureStationName: trainSolution.departureStation,
              );
              context.read<ExistBloc>().add(
                    ExistRequest(
                      savedTrain: savedTrain,
                    ),
                  );
            }
          : null,
      child: Column(
        children: [
          SolutionSectionHeader(
            trainType: trainSolution.trainType,
            trainCode: trainSolution.trainCode,
            departureTime: trainSolution.departureTime,
            arrivalTime: trainSolution.arrivalTime,
          ),
          SizedBox(height: kPadding / 2),
          SolutionSectionStations(
            trainSolution: trainSolution,
          ),
        ],
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: radius,
        ),
        padding: EdgeInsets.all(kPadding),
      ),
    );
  }

  get radius {
    if (size == 1) return BorderRadius.circular(kRadius);
    if (position == 0)
      return BorderRadius.vertical(
          top: Radius.circular(kRadius), bottom: Radius.zero);
    if (position == size! - 1)
      return BorderRadius.vertical(
          bottom: Radius.circular(kRadius), top: Radius.zero);
    return BorderRadius.zero;
  }
}
