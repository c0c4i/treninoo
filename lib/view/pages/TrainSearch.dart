// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:treninoo/view/components/button.dart';
// import 'package:treninoo/view/components/header.dart';
// import 'package:treninoo/view/components/textfield.dart';

// import 'package:treninoo/view/pages/TrainStatus.dart';
// import 'package:treninoo/view/components/recents.dart';

// import 'package:treninoo/model/SavedTrain.dart';

// import 'package:treninoo/utils/api.dart';
// import 'package:treninoo/utils/final.dart';
// import 'package:treninoo/utils/utils.dart';

// class TrainSearch extends StatefulWidget {
//   TrainSearch({Key key}) : super(key: key);

//   @override
//   _TrainSearchState createState() => _TrainSearchState();
// }

// class _TrainSearchState extends State<TrainSearch> {
//   int errorType = -1;

//   bool _isSearching = false;

//   TextEditingController inputController = TextEditingController();

//   Future<List<SavedTrain>> recents;

//   @override
//   void initState() {
//     super.initState();
//     recents = fetchSharedPreferenceWithListOf(spRecentsTrains);
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     inputController.dispose();
//     super.dispose();
//   }

//   String _errorType(String type) {
//     switch (errorType) {
//       case 0:
//         return 'E\' necessario inserire il codice'; // empty train code
//       case 1:
//         return 'Codice Treno non valido'; //invalid train code
//       case 2:
//         return 'Errore sconosciuto';
//       case 3:
//         return '(Argomento vuoto)'; // ricerca con trainStatus=""
//       case 4:
//         return 'Errore di connessione'; // nessuna connessione ad internet
//       default:
//         return null;
//     }
//   }

//   /* funzioni svolte quando viene premuto il tasto cerca:
//         - Zero treni: mostra errore 1
//         - Un treno: apre il treno con le informazioni
//         - Due treni: 
//   */
//   void searchButtonClick(String trainCode) {
//     _formKey.currentState.validate();
//     _isSearching = true;
//     FocusScope.of(context).unfocus();

//     if (trainCode.length == 0) {
//       setState(() {
//         errorType = 0;
//       });
//       _isSearching = false;
//       return;
//     }

//     getAvailableNumberOfTrain(trainCode).then((numberOfTrain) {
//       if (numberOfTrain == 0) {
//         // nessun treno
//         setState(() {
//           errorType = 1;
//         });
//         _isSearching = false;
//         return;
//       }

//       setState(() {
//         errorType = -1;
//       });

//       if (numberOfTrain == 1) {
//         // un treno
//         _isSearching = false;
//         getSpecificStationCode(trainCode).then((stationCode) {
//           Navigator.push(
//               context,
//               CupertinoPageRoute(
//                   builder: (context) => TrainStatusPage(
//                       trainCode: trainCode,
//                       stationCode: stationCode))).then((value) {
//             setState(() {
//               recents = fetchSharedPreferenceWithListOf(spRecentsTrains);
//             });
//           });
//         });
//       } else {
//         // più treni
//         _isSearching = false;
//         getMultipleTrainsType(trainCode)
//             .then((type) => _showDialogMultipleTrainType(type, trainCode));
//       }
//     }).catchError((err) {
//       int e = 2;
//       if (err is ArgumentError)
//         e = 3;
//       else if (err is SocketException) e = 4;

//       setState(() {
//         errorType = e;
//       });
//     });
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           minimum: EdgeInsets.all(8),
//           child: GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () {
//               FocusScopeNode currentFocus = FocusScope.of(context);
//               if (!currentFocus.hasPrimaryFocus) {
//                 currentFocus.unfocus();
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   // TopBar(text: 'Treninoo', location: SEARCH_TRAIN_STATUS),
//                   Header(
//                     title: "Cerca il tuo treno",
//                     description:
//                         "Se conosci il numero del tuo treno inseriscilo qui per conoscere il suo stato",
//                   ),
//                   SizedBox(height: 50),
//                   Form(
//                     key: _formKey,
//                     child: BeautifulTextField(
//                       prefixIcon: Icons.search,
//                       labelText: "Codice treno",
//                       controller: inputController,
//                       keyboardType: TextInputType.number,
//                       validator: _errorType,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ActionButton(
//                     title: "Cerca",
//                     onPressed: !_isSearching
//                         ? () => searchButtonClick(inputController.text)
//                         : null,
//                   ),
//                   Recents(recents: recents),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // dialogo di scelta treno se multiplo
//   void _showDialogMultipleTrainType(
//       Map<String, String> type, String trainCode) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Quale precisamente?"),
//           content: Container(
//             child: widgetMultipleTrainsType(type, trainCode),
//           ),
//         );
//       },
//     );
//   }

//   // widget con la lista dei tipi di treno con quel codice
//   Widget widgetMultipleTrainsType(Map<String, String> type, String trainCode) {
//     List<Widget> list = List<Widget>();

//     type.forEach((k, v) => list.add(
//           FlatButton(
//             onPressed: () {
//               setState(() {
//                 Navigator.pop(context);
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) => TrainStatusPage(
//                             trainCode: trainCode,
//                             stationCode: k))).then((value) => setState(() {
//                       recents =
//                           fetchSharedPreferenceWithListOf(spRecentsTrains);
//                     }));
//               });
//             },
//             child: Text(
//               trainNames.containsKey(v) ? trainNames[v] : v,
//               textScaleFactor: 2,
//             ),
//           ),
//         ));

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: list,
//     );
//   }
// }
