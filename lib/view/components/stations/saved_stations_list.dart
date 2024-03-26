import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations/stations.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/stations/station_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class SavedStationsList extends StatefulWidget {
  SavedStationsList({Key? key}) : super(key: key);

  @override
  _SavedStationsListState createState() => _SavedStationsListState();
}

class _SavedStationsListState extends State<SavedStationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        if (state is StationsSuccess && state.stations.length > 0) {
          return BeautifulCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Stazioni preferite e recenti",
                  style: Typo.bodyHeavy.copyWith(
                    color: Grey.dark,
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  itemCount: state.stations.length,
                  itemBuilder: (context, index) {
                    return StationCard(
                      station: state.stations[index].station,
                      isFavourite: state.stations[index].isFavourite,
                      onPressed: () {},
                    );
                  },
                ),
              ],
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
