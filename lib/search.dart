import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/utils.dart';

import 'topbar.dart';
import 'trainstatus.dart';
import 'recents.dart';
import 'newutils.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int errorType = -1;

  bool _isSearching = false;

  TextEditingController inputController = TextEditingController();

  Future<List<SavedTrain>> recents;

  @override
  void initState() {
    super.initState();
    recents = fetchSharedPreferenceWithListOf(shprRecentsTrains);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  String _errorType() {
    switch (errorType) {
      case 0:
        return 'E\' necessario inserire il codice'; // empty train code
      case 1:
        return 'Codice Treno non valido'; //invalid train code
      case 2:
        return 'Errore sconosciuto';
      case 3:
        return '(Argomento vuoto)'; // ricerca con trainStatus=""
      case 4:
        return 'Errore di connessione'; // nessuna connessione ad internet
      default:
        return null;
    }
  }

  /* funzioni svolte quando viene premuto il tasto cerca:
        - Zero treni: mostra errore 1
        - Un treno: apre il treno con le informazioni
        - Due treni: 
  */
  void searchButtonClick(String trainCode) {
    _isSearching = true;
    FocusScope.of(context).unfocus();

    if (trainCode.length == 0) {
      setState(() {
        errorType = 0;
      });
      _isSearching = false;
      return;
    }

    getAvailableNumberOfTrain(trainCode).then((numberOfTrain) {
      if (numberOfTrain == 0) {
        // nessun treno
        setState(() {
          errorType = 1;
        });
        _isSearching = false;
        return;
      }

      setState(() {
        errorType = -1;
      });

      if (numberOfTrain == 1) {
        // un treno
        _isSearching = false;
        getSpecificStationCode(trainCode).then((stationCode) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => TrainStatus(
                      trainCode: trainCode,
                      stationCode: stationCode))).then((value) {
            print("qui aggiorno il child");
            setState(() {
              recents = fetchSharedPreferenceWithListOf(shprRecentsTrains);
            });
          });
        });
      } else {
        // più treni
        _isSearching = false;
        getMultipleTrainsType(trainCode)
            .then((type) => _showDialogMultipleTrainType(type, trainCode));
      }
    }).catchError((err) {
      int e = 2;
      if (err is ArgumentError)
        e = 3;
      else if (err is SocketException) e = 4;

      setState(() {
        errorType = e;
      });
    });
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
                TopBar(text: 'Treninoo', location: SEARCH_TRAIN_STATUS),
                Container(
                  padding: EdgeInsets.only(top: 100, left: 7, right: 7),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TextField(
                            style: Theme.of(context).textTheme.display3,
                            keyboardType: TextInputType.number,
                            controller: inputController,
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
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                                size: 35,
                              ),
                              labelText: 'Inserire Codice Treno',
                              errorText: _errorType(),
                              errorStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                            focusNode: null),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            child: RaisedButton(
                              padding: EdgeInsets.only(
                                  left: 50, right: 50, top: 20, bottom: 20),
                              color: Theme.of(context).buttonColor,
                              onPressed: !_isSearching
                                  ? () =>
                                      searchButtonClick(inputController.text)
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                'Cerca',
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Recents(recents: recents),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // dialogo di scelta treno se multiplo
  void _showDialogMultipleTrainType(
      Map<String, String> type, String trainCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Quale precisamente?"),
          content: Container(
            child: widgetMultipleTrainsType(type, trainCode),
          ),
        );
      },
    );
  }

  // widget con la lista dei tipi di treno con quel codice
  Widget widgetMultipleTrainsType(Map<String, String> type, String trainCode) {
    List<Widget> list = List<Widget>();

    type.forEach((k, v) => list.add(
          FlatButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            TrainStatus(trainCode: trainCode, stationCode: k)));
              });
            },
            child: Text(
              trainNames.containsKey(v) ? trainNames[v] : v,
              textScaleFactor: 2,
            ),
          ),
        ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}
