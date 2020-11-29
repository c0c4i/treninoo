import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/TrainStatus.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';

class Recents extends StatefulWidget {
  Recents({Key key, this.recents}) : super(key: key);

  Future<List<SavedTrain>> recents;

  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  _RecentsState();

  // Future<List<SavedTrain>> recents;

  // @override
  // void initState() {
  //   super.initState();
  //   recents = fetchSharedPreferenceWithListOf("recents");
  // }

  // widget completo che ingloba i preferiti
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-1, 0),
      padding: EdgeInsets.only(top: 80, left: 7, right: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'Recenti',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          FutureBuilder(
            future: widget.recents,
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> projectSnap) {
              dynamic jsonDecoded = projectSnap.data;
              if (jsonDecoded == null || jsonDecoded.length == 0)
                return new Text(
                  "Nessun recente",
                  textAlign: TextAlign.center,
                );
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jsonDecoded.length,
                itemBuilder: (BuildContext context, int index) {
                  return _favouriteTrainWidget(jsonDecoded[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // preferito univoco
  Widget _favouriteTrainWidget(SavedTrain train) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ButtonTheme(
        padding: EdgeInsets.all(15),
        minWidth: double.infinity,
        child: RaisedButton(
          color: Theme.of(context).buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () {
            // _showFutureReleaseDialog();
            // return;
            setState(() {
              verifyIfTrainExist(train.departureStationCode, train.trainCode)
                  .then((exist) {
                if (exist) {
                  // cercalo
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => TrainStatus(
                              trainCode: train.trainCode,
                              stationCode: train.departureStationCode,
                            )),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Treno mofidicato"),
                        content: Text("Vuoi rimuoverlo dai recenti?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Elimina"),
                            onPressed: () {
                              SharedPrefJson.nowSearching = train;
                              SharedPrefJson.removeRecentTrain();
                              print("elimino");
                              setState(() {
                                widget.recents =
                                    fetchSharedPreferenceWithListOf(
                                        spRecentsTrains);
                              });
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Annulla"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // alert and delete
                }
              });
            });
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    train.trainType,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    train.trainCode,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      train.departureTime,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      train.departureStationName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      train.arrivalStationName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
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

  void _showFutureReleaseDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Treni recenti"),
          content: new Text("La funzione sarà inserita nella prossima release"),
          titlePadding:
              EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
          contentPadding:
              EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        );
      },
    );
  }
}
