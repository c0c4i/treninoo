import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'newutils.dart';
import 'topbar.dart';
import 'trainstatus.dart';

class Train {
  final String departure_station;
  final String arrival_station;
  final DateTime departure_time;
  final DateTime arrival_time;
  final String typeNumber; // sono infami e quindi String e non int come volevo
  final String trainType;
  final String trainCode;

  Train(
      {this.departure_station,
      this.arrival_station,
      this.departure_time,
      this.arrival_time,
      this.typeNumber,
      this.trainType,
      this.trainCode});

  factory Train.fromJson(Map<String, dynamic> json) {
    String typeNumber = json['categoria'];

    return Train(
        departure_station: json['origine'],
        arrival_station: json['destinazione'],
        departure_time: DateTime.parse(json['orarioPartenza']),
        arrival_time: DateTime.parse(json['orarioArrivo']),
        typeNumber: typeNumber,
        trainType: trainTypeFromNumber.containsKey(typeNumber)
            ? trainTypeFromNumber[typeNumber]
            : "EC",
        trainCode: json['numeroTreno']);
  }
}

class Solution {
  final String travelTime;
  final List<Train> trains;

  Solution({this.travelTime, this.trains});

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      travelTime: json['durata'],
      trains: (json['vehicles'] as List).map((f) => Train.fromJson(f)).toList(),
    );
  }
}

class Solutions {
  final List<Solution> solutions;
  final String departureStation;
  final String departureStationCode;
  final String arrivalStation;
  final String arrivalStationCode;
  final DateTime fromTime;

  Solutions({
    this.solutions,
    this.departureStation,
    this.departureStationCode,
    this.arrivalStation,
    this.arrivalStationCode,
    this.fromTime,
  });

  factory Solutions.fromJson(Map<String, dynamic> json, String departureCode,
      String arrivalCode, DateTime time) {
    if (json['soluzioni'].length == 0) {
      // trainInfoErrorType = 0;
      return null;
    }
    return Solutions(
      solutions:
          (json['soluzioni'] as List).map((f) => Solution.fromJson(f)).toList(),
      departureStation: json['origine'],
      departureStationCode: departureCode,
      arrivalStation: json['destinazione'],
      arrivalStationCode: arrivalCode,
      fromTime: time,
    );
  }
}

// COSA SERVE
//  - Codice Stazione di Partenza
//  - Codice Stazione di Arrivo
//  - Data

// http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/soluzioniViaggioNew/2593/2430/2019-05-06T23:14:00.000
Future<Solutions> fetchPostSolutions(
    String departureCode, String arrivalCode, DateTime time) async {
  await Future.delayed(
      const Duration(milliseconds: 250)); // just for graphic satisfaction
  String urlSolutions =
      "$URL_SOLUTIONS$departureCode/$arrivalCode/${time.toIso8601String()}";
  print(urlSolutions);

  final http.Response responseTrainStatus = await http.get(urlSolutions);

  Solutions s = new Solutions.fromJson(
      json.decode(responseTrainStatus.body), departureCode, arrivalCode, time);

  return s;
}

class TrainSolutions extends StatefulWidget {
  final String departureCode;
  final String arrivalCode;
  final DateTime time;

  TrainSolutions({Key key, this.departureCode, this.arrivalCode, this.time})
      : super(key: key);

  @override
  _TrainSolutionsState createState() => _TrainSolutionsState(data: this);
}

class _TrainSolutionsState extends State<TrainSolutions> {
  Future<Solutions> post;

  TrainSolutions data;
  _TrainSolutionsState({this.data}) : super();

  @override
  void initState() {
    super.initState();
    post = fetchPostSolutions(data.departureCode, data.arrivalCode, data.time);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Solutions>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _solutionsInfo(snapshot);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: _ifNotLoadedInfo(),
              ),
            ),
          );
        });
  }

  Widget _ifNotLoadedInfo() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // widget schermata completa trainInfo
  Widget _solutionsInfo(AsyncSnapshot snapshot) {
    Solutions data = snapshot.data;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          primary: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Theme.of(context).buttonColor,
                                  width: 2.0)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "${data.departureStation} - ${data.arrivalStation}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              "${getCustomDate(data.fromTime)}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${getCustomTime(data.fromTime)}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        _showSolution(snapshot),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showSolution(AsyncSnapshot snapshot) {
    Solutions data = snapshot.data;
    int nStop = data.solutions.length;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: nStop,
        itemBuilder: (BuildContext ctxt, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: Theme.of(context).buttonColor, width: 2.0)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          getLabelTrains(data.solutions[index].trains),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          travelTimeFormat(data.solutions[index].travelTime),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  _showSingleTrain(snapshot, index),
                ],
              ),
            ),
          );
        });
  }

  Widget _showSingleTrain(AsyncSnapshot snapshot, index) {
    Solutions s = snapshot.data;
    int nTrain = s.solutions[index].trains.length;
    List<Train> t = s.solutions[index].trains;

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: nTrain,
        itemBuilder: (BuildContext ctxt, int n) {
          return Padding(
            padding:
                (n == 0) ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 5),
            child: FlatButton(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
              color: Theme.of(context).buttonColor,
              onPressed: () {
                getSpecificStationCode(t[n].trainCode).then((stationCode) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => TrainStatus(
                              trainCode: t[n].trainCode,
                              stationCode: stationCode)));
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                        visible: t.length > 1,
                        child: Text(
                          "${t[n].trainType}${t[n].trainCode}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    Text(
                      "${getCustomTime(t[n].departure_time)}  ${t[n].departure_station}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${getCustomTime(t[n].arrival_time)}  ${t[n].arrival_station}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String getLabelTrains(List<Train> l) {
    String label = "";
    if (l.length == 1) {
      String trainType = l[0].trainType;
      label = trainType;
      return "$label${l[0].trainCode}";
    }

    for (int i = 0; i < l.length; i++) {
      label += l[i].trainType;
      label += (i != l.length - 1) ? " + " : "";
    }
    return label;
  }

  String travelTimeFormat(String time) {
    int hours = int.parse(time.split(":")[0]);
    int minutes = int.parse(time.split(":")[1]);

    return ("${hours}h ${minutes}m");
  }
}
