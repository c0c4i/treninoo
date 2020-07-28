import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'topbar.dart';
import 'newutils.dart';
import 'search_solution.dart';

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

  Map<String, String> suggestionDeparture;
  Map<String, String> suggestionArrival;


  final TextEditingController inputDepartureController = TextEditingController();
  final TextEditingController inputArrivalController = TextEditingController();
  // final inputDepartureController = TextEditingController();
  // final inputArrivalController = TextEditingController();

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
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputDepartureController.dispose();
    inputArrivalController.dispose();
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
                TopBar(text: 'Train Status', location: 0),
                Container(
                  padding: EdgeInsets.only(top: 100, left: 7, right: 7),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            controller: inputDepartureController,
                            style: Theme.of(context).textTheme.display3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)
                                  ),
                                ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)
                                ),
                              ),
                              prefixIcon: Icon(Icons.gps_fixed, size: 30, color: Theme.of(context).primaryColor),
                              labelText: 'Partenza',
                              errorStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            if(pattern.length > 2) {
                              suggestionDeparture = await getStationListStartWith(pattern);
                              return suggestionDeparture.keys.toList();
                            }
                            return null;
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (clicked) {
                            inputDepartureController.text = clicked;
                          }
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            controller: inputArrivalController,
                            style: Theme.of(context).textTheme.display3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)
                                  ),
                                ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)
                                ),
                              ),
                              prefixIcon: Icon(Icons.gps_fixed, size: 30, color: Theme.of(context).primaryColor),
                              labelText: 'Destinazione',
                              errorStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            if(pattern.length > 2) {
                              suggestionArrival = await getStationListStartWith(pattern);
                              return suggestionArrival.keys.toList();
                            }
                            return null;
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (clicked) {
                            inputArrivalController.text = clicked;
                          }
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        OutlineButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          highlightedBorderColor: Theme.of(context).primaryColor,
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
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            "  $_date",
                                            style: Theme.of(context).textTheme.display3,
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          highlightedBorderColor: Theme.of(context).primaryColor,
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
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            "  $_time",
                                            style: Theme.of(context).textTheme.display3,
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
                            padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                            color: Theme.of(context).buttonColor,
                            onPressed: () {
                              // searchStaticSolution();
                              _getSolutionRequest();
                              //searchButtonClick(inputController.text);
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
      firstDate: DateTime(DateTime.now().year-1),
      lastDate: DateTime(DateTime.now().year+1)
    );

    if(date != null)
      setState(() {
        pickedDate = date;
        _date = getCustomDate(date);
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(t != null)
      setState(() {
        time = t;
        String _hour = addZeroToNumberLowerThan10(t.hour.toString());
        String _minute = addZeroToNumberLowerThan10(t.minute.toString());
        _time = "$_hour:$_minute";
      });
  }

  _getSolutionRequest() {
    String departureCode = suggestionDeparture['${inputDepartureController.text}'];
    String arrivalCode = suggestionArrival['${inputArrivalController.text}'];

    Navigator.push(
      context, CupertinoPageRoute(
        builder: (context) => TrainSolutions(
          departureCode: departureCode, arrivalCode: arrivalCode, time: pickedDate)
    ));
  }
}