import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../bloc/exist/exist.dart';

class StationTrainCard extends StatelessWidget {
  final StationTrain stationTrain;
  final bool isDeparture;

  const StationTrainCard({
    Key? key,
    required this.stationTrain,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: OutlinedButton(
          onPressed: () {
            context.read<ExistBloc>().add(
                  ExistRequest(
                    savedTrain: SavedTrain.fromStationTrain(stationTrain),
                  ),
                );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      stationTrain.category! + " " + stationTrain.trainCode,
                      style: Typo.subheaderHeavy.copyWith(
                        color: Primary.normal,
                      ),
                    ),
                  ),
                  Text(
                    stationTrain.time!.format(context),
                    style: Typo.subheaderHeavy.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextWithIcon(
                icon: isDeparture
                    ? Icons.sports_score
                    : Icons.location_on_outlined,
                label: stationTrain.name,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextWithIcon(
                      icon: Icons.more_time,
                      label: getTime(stationTrain.delay),
                    ),
                  ),
                  // SizedBox(width: 32),
                  Expanded(
                    child: TextWithIcon(
                      icon: Icons.tag,
                      label: stationTrain.actualRail ??
                          stationTrain.plannedRail ??
                          "-",
                    ),
                  ),
                ],
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
            padding: EdgeInsets.all(kPadding),
          ),
        ));
  }

  String getTime(time) => time != 0 && time != null ? "$time min" : "In orario";
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        SizedBox(width: 8),
        Text(
          label!,
          style: Typo.subheaderHeavy.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        )
      ],
    );
  }
}
