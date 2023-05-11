import 'package:flutter/material.dart';

import 'package:treninoo/model/Station.dart';

import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/header.dart';

import 'package:treninoo/view/components/textfield.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class SearchStationPage extends StatefulWidget {
  SearchStationPage({Key key}) : super(key: key);

  @override
  _SearchStationPageState createState() => _SearchStationPageState();
}

class _SearchStationPageState extends State<SearchStationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  bool validate = false;
  Station station;

  searchButtonClick() {
    setState(() {
      validate = true;
    });

    if (station == null) return;

    setState(() {
      validate = false;
    });

    Navigator.pushNamed(context, RoutesNames.station, arguments: station);
  }

  String validator(Station station) {
    if (!validate) return null;
    if (station == null) return "Selezionare una stazione";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
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
                  Form(
                    key: _formKey,
                    child: SuggestionTextField(
                      label: "Stazione",
                      controller: searchController,
                      onSelect: (selected) {
                        searchController.text = selected.stationName;
                        setState(() => station = selected);
                      },
                      errorText: validator(station),
                    ),
                  ),
                  SizedBox(height: 20),
                  ActionButton(
                    title: "Cerca",
                    onPressed: searchButtonClick,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
