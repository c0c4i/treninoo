import 'package:flutter/material.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DepartureStationsDialog extends StatelessWidget {
  final List<DepartureStation> departureStations;

  static Future<DepartureStation> show(
    BuildContext context, {
    Key key,
    @required List<DepartureStation> departureStations,
  }) async =>
      await showDialog<DepartureStation>(
        context: context,
        builder: (_) => DepartureStationsDialog(
          key: key,
          departureStations: departureStations,
        ),
      );

  DepartureStationsDialog({
    Key key,
    @required this.departureStations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onTap: () => Navigator.pop(context, ds),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        );
      }).toList(),
    );
  }
}
