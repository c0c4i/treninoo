import 'package:flutter/material.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DepartureStationsDialog extends StatelessWidget {
  final List<DepartureStation> departureStations;

  static void show(
    BuildContext context, {
    Key key,
    List<DepartureStation> departureStations,
  }) =>
      showDialog<void>(
        context: context,
        builder: (_) => DepartureStationsDialog(
          key: key,
          departureStations: departureStations,
        ),
      );

  DepartureStationsDialog({
    Key key,
    this.departureStations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneWidth = MediaQuery.of(context).size.width;
    var dialogWidth = phoneWidth * 0.90;

    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Più treni trovati!",
            style: Typo.titleHeavy,
          ),
          SizedBox(height: 4),
          Text(
            "Qual è la stazione di partenza del tuo treno?",
            style: Typo.subheaderLight.copyWith(color: Grey.dark),
          ),
        ],
      ),
      contentPadding: EdgeInsets.all(kPadding),
      children: departureStations.map((ds) {
        return ListTile(
          title: Text(
            ds.station.stationName,
          ),
          onTap: () {
            Navigator.popAndPushNamed(
              context,
              RoutesNames.status,
              arguments: SavedTrain.fromDepartureStation(ds),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        );
      }).toList(),
    );
  }
}
