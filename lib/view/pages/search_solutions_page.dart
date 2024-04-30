import 'package:flutter/material.dart';

import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/dialog/date_time_picker.dart';
import 'package:treninoo/view/components/dialog/station_picker.dart';
import 'package:treninoo/view/components/dialog/train_type_dialog.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/buttons/station_picker_button.dart';

import 'package:treninoo/model/Station.dart';

import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';

import '../components/buttons/text_button.dart';

class SearchSolutionsPage extends StatefulWidget {
  SearchSolutionsPage({Key? key}) : super(key: key);

  @override
  _SearchSolutionsPageState createState() => _SearchSolutionsPageState();
}

class _SearchSolutionsPageState extends State<SearchSolutionsPage> {
  late DateTime pickedDate;

  Station? departureStation;
  Station? arrivalStation;

  TrainType trainType = TrainType.all;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  initFields() {
    setState(() {
      departureStation = null;
      arrivalStation = null;
      pickedDate = DateTime.now();
      trainType = TrainType.all;
    });
  }

  swapStations() {
    setState(() {
      Station? temp = departureStation;
      departureStation = arrivalStation;
      arrivalStation = temp;
    });
  }

  _pickDateTime() async {
    DateTime? dateTime = await BeautifulDateTimePickerDialog.show(
      context: context,
      initialDate: pickedDate,
    );

    if (dateTime != null)
      setState(() {
        pickedDate = dateTime;
      });
  }

  _getSolutionRequest() {
    if (departureStation == null) return;
    if (arrivalStation == null) return;

    pickedDate = pickedDate.toLocal();

    SolutionsInfo solutionsInfo = new SolutionsInfo(
      departureStation: departureStation!,
      arrivalStation: arrivalStation!,
      fromTime: pickedDate,
      trainType: trainType,
    );

    Navigator.pushNamed(
      context,
      RoutesNames.solutions,
      arguments: solutionsInfo,
    );
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Header(
                    title: "Trova il treno ideale",
                    description:
                        "Inserisci da dove vuoi partire e dove vuoi arrivare per trovare le soluzioni",
                  ),
                  SizedBox(height: 50),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              BeautifulCard(
                                child: StationPickerButton(
                                  title: "Stazione di partenza",
                                  content: departureStation?.stationName,
                                  onPressed: () async {
                                    Station? station =
                                        await StationPickerDialog.show(
                                      context: context,
                                    );

                                    if (station == null) return;
                                    setState(() => departureStation = station);
                                  },
                                ),
                              ),
                              SizedBox(height: kPadding),
                              BeautifulCard(
                                child: StationPickerButton(
                                  title: "Stazione di arrivo",
                                  content: arrivalStation?.stationName,
                                  onPressed: () async {
                                    Station? station =
                                        await StationPickerDialog.show(
                                      context: context,
                                    );

                                    if (station == null) return;
                                    setState(() => arrivalStation = station);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: kPadding),
                        SizedBox(
                          height: double.infinity,
                          width: 48,
                          child: OutlinedButton(
                            onPressed: swapStations,
                            child: Semantics(
                              label: "Scambia stazioni",
                              child: Icon(
                                Icons.swap_vert_rounded,
                                color: Primary.normal,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kRadius),
                              ),
                              backgroundColor: Theme.of(context).cardColor,
                              foregroundColor:
                                  Theme.of(context).iconTheme.color,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: kPadding),
                  BeautifulCard(
                    child: Column(
                      children: [
                        StationPickerButton(
                          title: "Data e ora",
                          content: formatDate(pickedDate),
                          onPressed: () => _pickDateTime(),
                        ),
                        Divider(thickness: 1, height: 1),
                        StationPickerButton(
                          title: "Tipo di treno",
                          content: trainType.label,
                          onPressed: () {
                            TrainTypeDialog.show(
                              context: context,
                              initialType: trainType,
                            ).then((value) {
                              if (value != null)
                                setState(() => trainType = value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kPadding),
                  ActionButton(
                    title: "Trova soluzioni",
                    onPressed: _getSolutionRequest,
                  ),
                  SizedBox(height: kPadding),
                  ActionTextButton(
                    title: "Pulisci ricerca",
                    onPressed: initFields,
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
