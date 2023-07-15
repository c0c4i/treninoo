import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../../model/Station.dart';

class DepartureStationsDialog extends StatelessWidget {
  final List<Station> departureStations;

  static Future<Station?> show(
    BuildContext context, {
    Key? key,
    required List<Station> departureStations,
  }) async =>
      await showDialog<Station>(
        context: context,
        builder: (_) => DepartureStationsDialog(
          key: key,
          departureStations: departureStations,
        ),
      );

  DepartureStationsDialog({
    Key? key,
    required this.departureStations,
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
      children: departureStations.map((station) {
        return ListTile(
          title: Text(station.stationName!),
          onTap: () => Navigator.pop(context, station),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        );
      }).toList(),
    );
  }
}
