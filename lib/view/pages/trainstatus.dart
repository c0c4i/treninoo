import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainStatusInfo.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/train_appbar.dart';

int trainInfoErrorType = -1;

// ritorna un oggetto TrainInfo creato dalla GET al Server
Future<TrainStatusInfo> fetchPostTrainInfo(
    String trainCode, String stationCode) async {
  await Future.delayed(
      const Duration(milliseconds: 250)); // just for graphic satisfaction

  if (stationCode == null) {
    trainInfoErrorType = 1;
    return null;
  }

  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  String timestamp = date.millisecondsSinceEpoch.toString();

  String urlTrainStatus =
      URL_TRAIN_INFO + stationCode + "/" + trainCode + "/" + timestamp;
  print(urlTrainStatus);
  final http.Response responseTrainStatus = await http.get(urlTrainStatus);
  if (responseTrainStatus.statusCode != 200) {
    trainInfoErrorType = 1;
    return null;
  }
  trainInfoErrorType = -1;
  return TrainStatusInfo.fromJson(json.decode(responseTrainStatus.body));
}

class TrainStatus extends StatefulWidget {
  final String trainCode;
  final String stationCode;

  TrainStatus({Key key, this.trainCode, this.stationCode}) : super(key: key);

  @override
  _TrainStatusState createState() => _TrainStatusState(data: this);
}

class _TrainStatusState extends State<TrainStatus> {
  Future<TrainStatusInfo> post;

  TrainStatus data;
  _TrainStatusState({this.data}) : super();

  String _trainInfoErrorType() {
    switch (trainInfoErrorType) {
      case 0:
        return 'Treno Cancellato';
      case 1:
        return 'Errore Server';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 5)).then(null);
    post = fetchPostTrainInfo(data.trainCode, data.stationCode);
  }

  Future<Null> refreshTrainStatus() async {
    setState(() {
      post = fetchPostTrainInfo(data.trainCode, data.stationCode);
    });
    await new Future.delayed(const Duration(milliseconds: 500));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrainStatusInfo>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _trainInfo(snapshot);
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

  // widget pre caricamento o gestione errori
  Widget _ifNotLoadedInfo() {
    String text = _trainInfoErrorType();
    if (text.length == 0)
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return Text(text);
  }

  // widget schermata completa trainInfo
  Widget _trainInfo(AsyncSnapshot snapshot) {
    TrainStatusInfo data = snapshot.data;

    SavedTrain t = SavedTrain(
        trainCode: data.trainCode,
        trainType: data.trainType,
        departureStationCode: data.departureStationCode,
        departureStationName: data.departureStationName,
        arrivalStationName: data.arrivalStationName,
        departureTime: data.departureTime);

    SharedPrefJson.nowSearching = t;

    SharedPrefJson.addRecentTrain(t);

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(8),
        child: RefreshIndicator(
          color: Theme.of(context).buttonColor,
          onRefresh: refreshTrainStatus,
          child: ListView(
            primary: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    // TopBar(
                    //     text: '${data.trainType} ${data.trainCode}',
                    //     location: 1),
                    TrainAppBar(
                      number: '${data.trainType} ${data.trainCode}',
                    ),
                    SizedBox(height: 8),
                    Container(
                      // alignment: Alignment(-1, 0),
                      // padding: EdgeInsets.only(top: 10, left: 7, right: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).buttonColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Theme.of(context).buttonColor,
                                      width: 2.0)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            (data.lastPositionRegister == '--')
                                                ? 'Non ancora partito'
                                                : '${data.lastPositionRegister}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          (data.lastPositionRegister == '--')
                                              ? SizedBox.shrink()
                                              : Text(
                                                  'Ultimo Rilevamento: ${data.lastTimeRegister}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      pickDelay(data.delay),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Arrivo   ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Partenza',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Stazione',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Bin.',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .color,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: Theme.of(context).buttonColor,
                                    width: 2.0)),
                            child: Column(
                              children: <Widget>[
                                _stopList(snapshot),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // widget lista delle fermate
  Widget _stopList(AsyncSnapshot snapshot) {
    TrainStatusInfo data = snapshot.data;
    int nStop = data.stops.length;
    int i = 0;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: nStop,
        itemBuilder: (BuildContext ctxt, int index) {
          i++;
          Column c = Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            pickOrNot(data.stops[index].actualArrivalTime, 1, i,
                                nStop),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            pickOrNot(data.stops[index].plannedArrivalTime, 1,
                                i, nStop),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            pickOrNot(data.stops[index].actualDepartureTime, 0,
                                i, nStop),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            pickOrNot(data.stops[index].plannedDepartureTime, 0,
                                i, nStop),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "${data.stops[index].name}",
                              style: TextStyle(
                                fontSize: 16,
                                color: (data.stops[index].name ==
                                        data.lastPositionRegister)
                                    ? Theme.of(context).buttonColor
                                    : null,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            pickBinary(data.stops[index].actualArrivalRail,
                                data.stops[index].actualDepartureRail),
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            pickBinary(data.stops[index].plannedArrivalRail,
                                data.stops[index].plannedDepartureRail),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
          if (i < nStop)
            c.children.add(
                Divider(color: Theme.of(context).textTheme.display1.color));
          return c;
        });
  }

  // stringa con numero binario oppure - (perché le API torna null se non è assegnato il binario)
  String pickBinary(String arrival, String departure) {
    if (departure != null) return departure;

    if (arrival != null) return arrival;

    return '-';
  }

  // type = 0 = departure
  // type = 1 = arrival
  // controllo dei null negli orari che riceve
  String pickOrNot(String test, int type, int index, int max) {
    if (index == 1 && type == 1) return '';

    if (index == max && type == 0) return '';

    if (test == null) return '-:-';

    return test;
  }

  String pickDelay(int delay) {
    if (delay < 0) return 'Anticipo ${delay * (-1)}\'';
    return 'Ritardo $delay\'';
  }
}
