import 'package:flutter/material.dart';

import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';

import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/buttons/station_picker_button.dart';
import 'package:treninoo/view/components/dialog/station_picker.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/stations/favourites_stations_list.dart';

import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class SearchStationPage extends StatefulWidget {
  SearchStationPage({Key? key}) : super(key: key);

  @override
  _SearchStationPageState createState() => _SearchStationPageState();
}

class _SearchStationPageState extends State<SearchStationPage> {
  final TextEditingController searchController = TextEditingController();
  Station? station;

  searchButtonClick() {
    if (station == null) return;
    Navigator.pushNamed(context, RoutesNames.station, arguments: station);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Column(
            children: <Widget>[
              Header(
                title: "Cerca la tua stazione",
                description:
                    "Ricerca la tua stazione per vedere tutti gli arrivi e le partenze",
              ),
              SizedBox(height: 50),
              BeautifulCard(
                child: StationPickerButton(
                  title: "Stazione",
                  content: station?.stationName,
                  onPressed: () async {
                    Station? station = await StationPickerDialog.show(
                      context: context,
                    );

                    if (station == null) return;
                    setState(() => this.station = station);
                  },
                ),
              ),
              SizedBox(height: kPadding),
              ActionButton(
                title: "Cerca",
                onPressed: searchButtonClick,
              ),
              SizedBox(height: kPadding * 2),
              FavouritesStationsList(
                onSelected: (station) {
                  Navigator.pushNamed(
                    context,
                    RoutesNames.station,
                    arguments: station,
                  );
                },
              ),
              SizedBox(height: kPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
