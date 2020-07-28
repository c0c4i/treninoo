import 'package:flutter/material.dart';
import 'newutils.dart';
import 'utils.dart';
import 'trainstatus.dart';
import 'theme.dart';

class FavouriteTrain {
  final String favTrainCode;
  final String favTrainType;
  final String favDepartureStationCode;
  final String favDepartureStationName;
  final String favArrivalStationName;
  final String favDepartureTime;
  
  FavouriteTrain({
    this.favTrainCode,
    this.favTrainType,
    this.favDepartureStationCode,
    this.favDepartureStationName,
    this.favArrivalStationName,
    this.favDepartureTime,
  });

  Map<String, dynamic> toJson() => {
    'favTrainCode':            favTrainCode,
    'favTrainType':            favTrainType,
    'favDepartureStationCode': favDepartureStationCode,
    'favDepartureStationName': favDepartureStationName,
    'favArrivalStationName':   favArrivalStationName,
    'favDepartureTime':        favDepartureTime,
  };

  factory FavouriteTrain.fromJson(Map<String, dynamic> json) {
    return FavouriteTrain(
      favTrainCode:            json['favTrainCode'],
      favTrainType:            json['favTrainType'],
      favDepartureStationCode: json['favDepartureStationCode'],
      favDepartureStationName: json['favDepartureStationName'],
      favArrivalStationName:   json['favArrivalStationName'],
      favDepartureTime:        json['favDepartureTime'],
    );
  }
}

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
            future: SharedPrefJson.read("favorites"),
            builder: (BuildContext context, AsyncSnapshot<dynamic> projectSnap) {
              dynamic jsonDecoded = projectSnap.data;
              if (jsonDecoded == null)
                return new Text("Nessun preferito");
              List<FavouriteTrain> list = (jsonDecoded as List<dynamic>).map((e) => FavouriteTrain.fromJson(e)).toList();
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
    );
  }


  // preferito univoco
  Widget _favouriteTrainWidget(FavouriteTrain train) {
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
              _showFutureReleaseDialog();return;
              setState(() {
                verifyIfTrainExist(train.favDepartureStationCode, train.favTrainCode).then((exist) {
                  if(exist) {
                    // cercalo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainStatus(
                          trainCode: '2747',
                          stationCode: 'S02430',
                        )
                      ),
                    );
                  } else {
                    print("Il treno è stato modificato o non esiste più. Verificare nell'app trenitalia.");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Il treno è stato mofidicato o non esiste più.\nVuoi eliminarlo dai preferiti?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Elimina"),
                              onPressed: (){},
                            ),
                            FlatButton(
                              child: Text("Annulla"),
                              onPressed: (){
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
                    train.favTrainType,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    train.favTrainCode,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                  Expanded(
                    child: Text(
                      train.favDepartureTime,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
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
                      train.favDepartureStationName,
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
                      train.favArrivalStationName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
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





  void _showFutureReleaseDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Treni recenti"),
          content: new Text("La funzione sarà inserita nella prossima release"),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
          contentPadding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
        );
      },
    );
  }
}