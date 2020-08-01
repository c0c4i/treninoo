import 'package:flutter/material.dart';
import 'package:treninoo/topbar.dart';
import 'newutils.dart';
import 'utils.dart';
import 'trainstatus.dart';
import 'theme.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key, this.trainCode, this.stationCode}) : super(key: key);

  final String trainCode;
  final String stationCode;

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  _FavouritesState();

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
                  future: SharedPrefJson.read("favourite"),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> projectSnap) {
                    dynamic jsonDecoded = projectSnap.data;
                    if (jsonDecoded == null)
                      return new Text("Nessun preferito");
                    List<SavedTrain> list = (jsonDecoded as List<dynamic>)
                        .map((e) => SavedTrain.fromJson(e))
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _favouriteTrainWidget(list[index]);
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
            _showFutureReleaseDialog();
            return;
            setState(() {
              verifyIfTrainExist(train.departureStationCode, train.trainCode)
                  .then((exist) {
                if (exist) {
                  // cercalo
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrainStatus(
                              trainCode: '2747',
                              stationCode: 'S02430',
                            )),
                  );
                } else {
                  print(
                      "Il treno è stato modificato o non esiste più. Verificare nell'app trenitalia.");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text(
                            "Il treno è stato mofidicato o non esiste più.\nVuoi eliminarlo dai preferiti?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Elimina"),
                            onPressed: () {},
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
