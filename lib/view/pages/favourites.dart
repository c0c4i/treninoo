import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:treninoo/view/components/topbar.dart';
import 'package:treninoo/view/pages/trainstatus.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/utils/final.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key, this.trainCode, this.stationCode}) : super(key: key);

  final String trainCode;
  final String stationCode;

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  _FavouritesState();

  Future<List<SavedTrain>> favourites;

  @override
  void initState() {
    super.initState();
    favourites = _fetchFavourites();
  }

  // widget completo che ingloba i preferiti
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TopBar(text: 'Treninoo', location: SEARCH_TRAIN_STATUS),
                FutureBuilder(
                  future: favourites,
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> projectSnap) {
                    dynamic jsonDecoded = projectSnap.data;
                    if (jsonDecoded == null || jsonDecoded.length == 0)
                      return new Text(
                        "Nessun preferito",
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
          ),
        ),
      ),
    );
  }

  Future<List<SavedTrain>> _fetchFavourites() async {
    final pref = await SharedPrefJson.read(spFavouritesTrains);
    if (pref == null) return null;
    return (pref as List<dynamic>).map((e) => SavedTrain.fromJson(e)).toList();
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
                  ).then((value) {
                    print("Sono tornato indietro e faccio il fetch");
                    setState(() {
                      favourites = _fetchFavourites();
                    });
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Treno mofidicato"),
                        content: Text("Vuoi rimuoverlo dai preferiti?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Rimuovi"),
                            onPressed: () {
                              SharedPrefJson.nowSearching = train;
                              SharedPrefJson.removeFavourite();
                              setState(() {
                                favourites = _fetchFavourites();
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
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Vuoi rimuovere il treno dai preferiti?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Rimuovi"),
                      onPressed: () {
                        SharedPrefJson.nowSearching = train;
                        SharedPrefJson.removeFavourite();
                        setState(() {
                          favourites = _fetchFavourites();
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
