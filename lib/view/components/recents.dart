import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/view/components/train_card.dart';

import '../pages/train_status_page.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50),
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Recenti", style: TextStyle(fontSize: 26)),
        ),
        SizedBox(height: 16),
        FutureBuilder(
          future: widget.recents,
          builder: (BuildContext context, AsyncSnapshot<dynamic> projectSnap) {
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
    );
  }

  // preferito univoco
  Widget _favouriteTrainWidget(SavedTrain train) {
    return TrainCard(
      train: train,
      onPressed: () async {
        var exist = await verifyIfTrainExist(
            train.departureStationCode, train.trainCode);

        if (exist) {
          // cercalo
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //       builder: (context) => TrainStatusPage(
          //             trainCode: train.trainCode,
          //             stationCode: train.departureStationCode,
          //           )),
          // );
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
                      // SharedPrefJson.nowSearching = train;
                      // SharedPrefJson.removeRecentTrain();
                      // print("elimino");
                      // setState(() {
                      //   widget.recents =
                      //       fetchSharedPreferenceWithListOf(spRecentsTrains);
                      // });
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
        }
      },
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
