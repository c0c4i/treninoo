import 'package:flutter/material.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/view/style/theme.dart';

class StationTrainCard extends StatelessWidget {
  final StationTrain stationTrain;

  const StationTrainCard({
    Key key,
    this.stationTrain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            // context.read<ExistBloc>().add(ExistRequest(savedTrain: savedTrain));
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      stationTrain.category + " " + stationTrain.trainCode,
                      style: TextStyle(
                          color: AppColors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    stationTrain.time,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextWithIcon(
                icon: stationTrain.isDeparture
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).scaffoldBackgroundColor),
            elevation: MaterialStateProperty.all<double>(4),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(16)),
          ),
        ));
  }

  String getTime(time) => time != 0 ? "$time min" : "On time";
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        )
      ],
    );
  }
}
