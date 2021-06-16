import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/view/components/button.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/loading_dialog.dart';
import 'package:treninoo/view/components/textfield.dart';

import 'package:treninoo/view/pages/TrainStatus.dart';
import 'package:treninoo/view/components/recents.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/final.dart';
import 'package:treninoo/utils/utils.dart';

class SearchTrainPage extends StatefulWidget {
  SearchTrainPage({Key key}) : super(key: key);

  @override
  _SearchTrainPageState createState() => _SearchTrainPageState();
}

class _SearchTrainPageState extends State<SearchTrainPage> {
  int errorType = -1;

  TextEditingController searchController = TextEditingController();

  Future<List<SavedTrain>> recents;

  @override
  void initState() {
    super.initState();
    recents = fetchSharedPreferenceWithListOf(spRecentsTrains);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  String _errorType(String text) {
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
  void searchButtonClick() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      String trainCode = searchController.text;
      if (trainCode.length == 0) {
        setState(() {
          errorType = 0;
        });
        return;
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(8),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: BlocListener<DepartureStationBloc, DepartureStationState>(
              listener: (context, state) {
                if (state is DepartureStationLoading)
                  LoadingDialog.show(context);
                if (state is DepartureStationSuccess) {
                  LoadingDialog.hide(context);
                  int trainFound = state.departureStations.length;
                  if (trainFound == 0) {
                    setState(() {
                      errorType = 1;
                    });
                  } else if (trainFound > 1) {
                    print("Più treni trovati!");
                  } else {
                    print("Treno trovato!");
                    print(state.departureStations[0].station);
                    print(state.departureStations[0].trainCode);
                  }
                }
                if (state is DepartureStationFailed)
                  LoadingDialog.hide(context);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // TopBar(text: 'Treninoo', location: SEARCH_TRAIN_STATUS),
                    Header(
                      title: "Cerca il tuo treno",
                      description:
                          "Se conosci il numero del tuo treno inseriscilo qui per conoscere il suo stato",
                    ),
                    SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: BeautifulTextField(
                        prefixIcon: Icons.search,
                        labelText: "Codice treno",
                        controller: searchController,
                        keyboardType: TextInputType.number,
                        validator: _errorType,
                      ),
                    ),
                    SizedBox(height: 20),
                    ActionButton(
                        title: "Cerca", onPressed: () => searchButtonClick()),
                    Recents(recents: recents),
                  ],
                ),
              ),
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
                        builder: (context) => TrainStatus(
                            trainCode: trainCode,
                            stationCode: k))).then((value) => setState(() {
                      recents =
                          fetchSharedPreferenceWithListOf(spRecentsTrains);
                    }));
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
