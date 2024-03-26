import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/stations/station_card.dart';

class StationsList extends StatelessWidget {
  final List<Station> stations;
  final Function(Station) onSelected;

  StationsList({
    Key? key,
    required this.stations,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BeautifulCard(
      child: ListView.separated(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return StationCard(
            station: stations[index],
            onPressed: () => onSelected(stations[index]),
          );
        },
        physics: ClampingScrollPhysics(),
        separatorBuilder: (context, index) => Divider(thickness: 1, height: 1),
      ),
    );
  }
}
