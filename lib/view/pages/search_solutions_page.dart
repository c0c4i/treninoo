import 'package:flutter/material.dart';

import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/dialog/time_picker.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/textfield.dart';

import 'package:treninoo/model/Station.dart';

import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';

import '../components/buttons/text_button.dart';
import '../components/dialog/date_picker.dart';

class SearchSolutionsPage extends StatefulWidget {
  SearchSolutionsPage({Key? key}) : super(key: key);

  @override
  _SearchSolutionsPageState createState() => _SearchSolutionsPageState();
}

class _SearchSolutionsPageState extends State<SearchSolutionsPage> {
  DateTime? pickedDate;
  late TimeOfDay pickedTime;
  late bool validate;

  TextEditingController departureController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Station? departureStation;
  Station? arrivalStation;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  initFields() {
    setState(() {
      departureStation = null;
      arrivalStation = null;
      departureController.text = '';
      arrivalController.text = '';
      pickedDate = DateTime.now();
      pickedTime = TimeOfDay.now();
      dateController.text = formatDate(pickedDate!);
      timeController.text = formatTimeOfDay(pickedTime);
      validate = false;
    });
  }

  String? validator(Station? station) {
    if (!validate) return null;
    if (station == null) return "Selezionare una stazione";
    return null;
  }

  swapStations() {
    setState(() {
      Station? temp = departureStation;
      departureStation = arrivalStation;
      arrivalStation = temp;

      departureStation != null
          ? departureController.text = departureStation!.stationName!
          : departureController.text = '';

      arrivalStation != null
          ? arrivalController.text = arrivalStation!.stationName!
          : arrivalController.text = '';
    });
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
                              SuggestionTextField(
                                label: "Partenza",
                                controller: departureController,
                                onSelect: (station) {
                                  if (station == null) return;
                                  departureController.text =
                                      station.stationName!;
                                  setState(() => departureStation = station);
                                },
                                errorText: validator(departureStation),
                              ),
                              SizedBox(height: 20),
                              SuggestionTextField(
                                label: "Destinazione",
                                controller: arrivalController,
                                onSelect: (station) {
                                  if (station == null) return;
                                  arrivalController.text = station.stationName!;
                                  setState(() => arrivalStation = station);
                                },
                                errorText: validator(arrivalStation),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: kPadding),
                        SizedBox(
                          height: double.infinity,
                          width: 48,
                          child: TextButton(
                            onPressed: swapStations,
                            child: Icon(
                              Icons.swap_vert_rounded,
                              color: Primary.normal,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Grey.lightest1,
                              side: BorderSide(
                                color: Grey.light,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(kRadius),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ClickableTextField(
                    prefixIcon: Icons.date_range_rounded,
                    labelText: "Data",
                    controller: dateController,
                    onPressed: () {
                      _pickDate();
                    },
                  ),
                  SizedBox(height: 20),
                  ClickableTextField(
                    prefixIcon: Icons.access_time_rounded,
                    labelText: "Ora",
                    controller: timeController,
                    onPressed: () {
                      _pickTime();
                    },
                  ),
                  SizedBox(height: 20),
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

  _pickDate() async {
    // DateTime date = await showDatePicker(
    //   context: context,
    //   initialDate: pickedDate,
    //   firstDate: DateTime(DateTime.now().year - 1),
    //   lastDate: DateTime(DateTime.now().year + 1),
    //   locale: const Locale('it'),
    //   selectableDayPredicate: _decideWhichDayToEnable,
    //   // builder: (context, child) {
    //   //   return Theme(
    //   //     data: ThemeData(primarySwatch: Colo),
    //   //     child: child,
    //   //   );
    //   // },
    // );

    DateTime? date = await BeautifulDatePickerDialog.show(
      context: context,
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
        dateController.text = formatDate(date);
      });
  }

  _pickTime() async {
    DateTime startTime = new DateTime(
      pickedDate!.year,
      pickedDate!.month,
      pickedDate!.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    DateTime? dateTime = await BeautifulTimePickerDialog.show(
      context: context,
      initialDate: startTime,
    );

    if (dateTime != null)
      setState(() {
        pickedTime = TimeOfDay.fromDateTime(dateTime);
        timeController.text = formatTimeOfDay(pickedTime);
      });
  }

  // bool _decideWhichDayToEnable(DateTime day) {
  //   if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
  //     return true;
  //   }
  //   return false;
  // }

  _getSolutionRequest() {
    setState(() {
      validate = true;
    });

    if (departureStation == null) return;
    if (arrivalStation == null) return;

    setState(() {
      validate = false;
    });

    pickedDate = pickedDate!.toLocal();
    pickedDate = new DateTime(pickedDate!.year, pickedDate!.month,
        pickedDate!.day, pickedTime.hour, pickedTime.minute);

    SolutionsInfo solutionsInfo = new SolutionsInfo(
      departureStation: departureStation,
      arrivalStation: arrivalStation,
      fromTime: pickedDate,
    );

    Navigator.pushNamed(
      context,
      RoutesNames.solutions,
      arguments: solutionsInfo,
    );
  }
}
