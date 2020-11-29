import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:treninoo/utils/utils.dart';

import '../components/topbar.dart';
import '../../utils/api.dart';
import 'search_solution.dart';

import 'package:treninoo/utils/core.dart';
import 'package:treninoo/model/Station.dart';

class SearchSolutions extends StatefulWidget {
  SearchSolutions({Key key}) : super(key: key);

  @override
  _SearchSolutionsState createState() => _SearchSolutionsState();
}

class _SearchSolutionsState extends State<SearchSolutions> {
  String _date;
  String _time;
  DateTime pickedDate;
  TimeOfDay time;

  List<Station> suggestionDeparture = new List<Station>();
  List<Station> suggestionArrival = new List<Station>();

  TextEditingController inputDepartureController = TextEditingController();
  TextEditingController inputArrivalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    String _day = addZeroToNumberLowerThan10(pickedDate.day.toString());
    String _month = addZeroToNumberLowerThan10(pickedDate.month.toString());
    _date = "$_day/$_month/${pickedDate.year}";

    String _hour = addZeroToNumberLowerThan10(time.hour.toString());
    String _minute = addZeroToNumberLowerThan10(time.minute.toString());
    _time = "$_hour:$_minute";

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Column(
              children: <Widget>[
                TopBar(text: 'Treninoo', location: 0),
                Container(
                  padding: EdgeInsets.only(top: 100, left: 7, right: 7),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TypeAheadField(
                            getImmediateSuggestions: true,
                            hideOnEmpty: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              controller: inputDepartureController,
                              style: Theme.of(context).textTheme.display3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                prefixIcon: Icon(Icons.gps_fixed,
                                    size: 30,
                                    color: Theme.of(context).primaryColor),
                                labelText: 'Partenza',
                                errorStyle: TextStyle(fontSize: 15),
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return suggestionCreator(pattern, 0);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (clicked) {
                              inputDepartureController.text = clicked;
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        TypeAheadField(
                            getImmediateSuggestions: true,
                            hideOnEmpty: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              controller: inputArrivalController,
                              style: Theme.of(context).textTheme.display3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                prefixIcon: Icon(Icons.gps_fixed,
                                    size: 30,
                                    color: Theme.of(context).primaryColor),
                                labelText: 'Destinazione',
                                errorStyle: TextStyle(fontSize: 15),
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return suggestionCreator(pattern, 1);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (clicked) {
                              inputArrivalController.text = clicked;
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.only(
                              left: 5, right: 10, top: 5, bottom: 5),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          highlightedBorderColor:
                              Theme.of(context).primaryColor,
                          textColor: Theme.of(context).primaryColor,
                          hoverColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            _pickDate();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 35.0,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            "  $_date",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Cambia",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.only(
                              left: 5, right: 10, top: 5, bottom: 5),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          highlightedBorderColor:
                              Theme.of(context).primaryColor,
                          textColor: Theme.of(context).primaryColor,
                          hoverColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            _pickTime();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 35.0,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            "  $_time",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display3,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Cambia",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                left: 50, right: 50, top: 20, bottom: 20),
                            color: Theme.of(context).buttonColor,
                            onPressed: () {
                              _getSolutionRequest();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              'Cerca Soluzioni',
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
        _date = getCustomDate(date);
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
        time = t;
        String _hour = addZeroToNumberLowerThan10(t.hour.toString());
        String _minute = addZeroToNumberLowerThan10(t.minute.toString());
        _time = "$_hour:$_minute";
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
        time.hour, time.minute);

    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => TrainSolutions(
                departureCode: departure.stationCode,
                arrivalCode: arrival.stationCode,
                time: pickedDate)));
  }
}
