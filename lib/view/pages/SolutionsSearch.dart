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

  List<Station> suggestionDeparture = [];
  List<Station> suggestionArrival = [];

  TextEditingController inputDepartureController = TextEditingController();
  TextEditingController inputArrivalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

    fetchRecentsStations(spRecentsStations).then((value) {
      suggestionDeparture = value;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // inputDepartureController.dispose();
    // inputArrivalController.dispose();
    super.dispose();
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
                    title: "Cerca il tuo treno",
                    description:
                        "Se conosci il numero del tuo treno inseriscilo qui per conoscere il suo stato",
                  ),
                  SizedBox(height: 50),
                  TypeAheadField(
                      getImmediateSuggestions: true,
                      hideOnEmpty: true,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        elevation: 8,
                        shadowColor: Colors.red,
                      ),
                      textFieldConfiguration: TextFieldConfiguration(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        controller: inputDepartureController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          prefixIcon: PrefixIcon(icon: Icons.gps_fixed_rounded),
                          labelText: 'Partenza',
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return suggestionCreator(pattern, 0);
                      },
                      itemBuilder: (context, suggestion) {
                        return SuggestionRow(suggestion: suggestion);
                      },
                      onSuggestionSelected: (clicked) {
                        inputDepartureController.text = clicked;
                      }),
                  SizedBox(height: 20),
                  TypeAheadField(
                      getImmediateSuggestions: true,
                      hideOnEmpty: true,
                      textFieldConfiguration: TextFieldConfiguration(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        controller: inputArrivalController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          prefixIcon: PrefixIcon(icon: Icons.gps_fixed_rounded),
                          labelText: 'Destinazione',
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return suggestionCreator(pattern, 1);
                      },
                      itemBuilder: (context, suggestion) {
                        return SuggestionRow(suggestion: suggestion);
                      },
                      onSuggestionSelected: (clicked) {
                        inputArrivalController.text = clicked;
                      }),
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

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }

  Future<List<String>> suggestionCreator(String s, int type) async {
    List<String> names = List<String>();
    if (s.length > 0) {
      await getStationListStartWith(s).then((value) {
        // serve per poi cercare e prendere il codice del treno - serve refactor
        (type == 0) ? suggestionDeparture = value : suggestionArrival = value;
        value.forEach((element) {
          names.add(element.stationName);
        });
      });
      return names;
    } else {
      fetchRecentsStations(spRecentsStations).then((value) {
        if (value.length == 0) return null;
        (type == 0) ? suggestionDeparture = value : suggestionArrival = value;
        value.forEach((element) {
          names.add(element.stationName);
        });
      });
    }
    return names;
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

  _getSolutionRequest() {
    Station departure = new Station(
        stationName: inputDepartureController.text,
        stationCode: getStationCodeByStationName(
            inputDepartureController.text, suggestionDeparture));

    Station arrival = new Station(
        stationName: inputArrivalController.text,
        stationCode: getStationCodeByStationName(
            inputArrivalController.text, suggestionArrival));

    SharedPrefJson.addRecentStation(departure);
    SharedPrefJson.addRecentStation(arrival);

    pickedDate = pickedDate.toLocal();
    pickedDate = new DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);

    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => SolutionsResult(
                departureCode: departure.stationCode,
                arrivalCode: arrival.stationCode,
                time: pickedDate)));
  }
}
