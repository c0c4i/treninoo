import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:treninoo/view/components/button.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/prefixicon.dart';
import 'package:treninoo/view/components/suggestion_row.dart';
import 'package:treninoo/view/components/textfield.dart';

import 'package:treninoo/view/components/topbar.dart';
import 'package:treninoo/view/pages/SolutionsResult.dart';

import 'package:treninoo/model/Station.dart';

import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/utils/api.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionsSearch extends StatefulWidget {
  SolutionsSearch({Key key}) : super(key: key);

  @override
  _SolutionsSearchState createState() => _SolutionsSearchState();
}

class _SolutionsSearchState extends State<SolutionsSearch> {
  DateTime pickedDate;
  TimeOfDay pickedTime;

  TextEditingController departureController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Station departureStation;
  Station arrivalStation;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
    String _day = addZeroToNumberLowerThan10(pickedDate.day.toString());
    String _month = addZeroToNumberLowerThan10(pickedDate.month.toString());
    String date = "$_day/$_month/${pickedDate.year}";
    dateController.text = date;

    String _hour = addZeroToNumberLowerThan10(pickedTime.hour.toString());
    String _minute = addZeroToNumberLowerThan10(pickedTime.minute.toString());
    String time = "$_hour:$_minute";
    timeController.text = time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(8),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Header(
                    title: "Trova il treno ideale",
                    description:
                        "Inserisci da dove vuoi partire e dove vuoi arrivare per trovare le soluzioni",
                  ),
                  SizedBox(height: 50),
                  SuggestionTextField(
                    label: "Partenza",
                    controller: departureController,
                    onSelect: (station) {
                      setState(() {
                        departureStation = station;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  SuggestionTextField(
                    label: "Destinazione",
                    controller: arrivalController,
                    onSelect: (station) {
                      setState(() {
                        arrivalStation = station;
                      });
                    },
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      locale: const Locale('it'),
      selectableDayPredicate: _decideWhichDayToEnable,
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData(primarySwatch: Colo),
      //     child: child,
      //   );
      // },
    );

    if (date != null)
      setState(() {
        pickedDate = date;
        dateController.text = getCustomDate(date);
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (t != null)
      setState(() {
        pickedTime = t;
        String _hour = addZeroToNumberLowerThan10(t.hour.toString());
        String _minute = addZeroToNumberLowerThan10(t.minute.toString());
        timeController.text = "$_hour:$_minute";
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }

  _getSolutionRequest() {
    SharedPrefJson.addRecentStation(departureStation);
    SharedPrefJson.addRecentStation(arrivalStation);

    pickedDate = pickedDate.toLocal();
    pickedDate = new DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);

    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => SolutionsResult(
              departureCode: departureStation.stationCode,
              arrivalCode: arrivalStation.stationCode,
              time: pickedDate),
        ));
  }
}
