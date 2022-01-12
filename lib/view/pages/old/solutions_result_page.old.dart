// import 'dart:async';
// import 'dart:core';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:treninoo/model/SolutionsInfo.dart';

// import 'package:treninoo/view/components/solutions_appbar.dart';

// import 'package:treninoo/model/Solutions.dart';

// import 'package:treninoo/utils/api.dart';
// import 'package:treninoo/utils/core.dart';

// class SolutionsResultPage extends StatefulWidget {
//   final SolutionsInfo solutionsInfo;

//   SolutionsResultPage({Key key, this.solutionsInfo}) : super(key: key);

//   @override
//   _SolutionsResultPageState createState() => _SolutionsResultPageState();
// }

// class _SolutionsResultPageState extends State<SolutionsResultPage> {
//   Solutions solutions;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Solutions>(
//         future: post,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return _solutionsInfo(snapshot);
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }
//           return Scaffold(
//             body: SafeArea(
//               child: Center(
//                 child: _ifNotLoadedInfo(),
//               ),
//             ),
//           );
//         });
//   }

//   Widget _ifNotLoadedInfo() {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   // widget schermata completa trainInfo
//   Widget _solutionsInfo(AsyncSnapshot snapshot) {
//     Solutions data = snapshot.data;

//     return Scaffold(
//       body: SafeArea(
//         minimum: EdgeInsets.all(8),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: <Widget>[
//                 SolutionsAppBar(),
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).buttonColor,
//                       borderRadius: BorderRadius.circular(kRadius),
//                       border: Border.all(
//                           color: Theme.of(context).buttonColor, width: 2.0)),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                           child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Center(
//                             child: Text(
//                               "${data.departureStation} - ${data.arrivalStation}",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Padding(padding: EdgeInsets.only(top: 10)),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Expanded(
//                                   flex: 2,
//                                   child: Center(
//                                     child: Text(
//                                       "${getCustomDate(data.fromTime)}",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     "${getCustomTime(data.fromTime)}",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                     ],
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.only(top: 10)),
//                 _showSolution(snapshot),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _showSolution(AsyncSnapshot snapshot) {
//     Solutions data = snapshot.data;
//     int nStop = data.solutions.length;
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: nStop,
//         itemBuilder: (BuildContext ctxt, int index) {
//           return Padding(
//             padding: EdgeInsets.only(top: 5, bottom: 5),
//             child: Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   border: Border.all(
//                       color: Theme.of(context).buttonColor, width: 2.0)),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           getLabelTrains(data.solutions[index].trains),
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Text(
//                           travelTimeFormat(data.solutions[index].travelTime),
//                           textAlign: TextAlign.right,
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(padding: EdgeInsets.only(bottom: 5)),
//                   _showSingleTrain(snapshot, index),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget _showSingleTrain(AsyncSnapshot snapshot, index) {
//     Solutions s = snapshot.data;
//     int nTrain = s.solutions[index].trains.length;
//     List<TrainSolutionInfo> t = s.solutions[index].trains;

//     return ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: nTrain,
//         itemBuilder: (BuildContext ctxt, int n) {
//           return Padding(
//             padding:
//                 (n == 0) ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 5),
//             child: FlatButton(
//               padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
//               color: Theme.of(context).buttonColor,
//               onPressed: () {
//                 getSpecificStationCode(t[n].trainCode).then((stationCode) {
//                   Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                           builder: (context) => TrainStatusPage(
//                               trainCode: t[n].trainCode,
//                               stationCode: stationCode)));
//                 });
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0)),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Visibility(
//                         visible: t.length > 1,
//                         child: Text(
//                           "${t[n].trainType}${t[n].trainCode}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                           ),
//                         )),
//                     Text(
//                       "${getCustomTime(t[n].departure_time)}  ${t[n].departure_station}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       "${getCustomTime(t[n].arrival_time)}  ${t[n].arrival_station}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   String getLabelTrains(List<TrainSolutionInfo> l) {
//     String label = "";
//     if (l.length == 1) {
//       String trainType = l[0].trainType;
//       label = trainType;
//       return "$label${l[0].trainCode}";
//     }

//     for (int i = 0; i < l.length; i++) {
//       label += l[i].trainType;
//       label += (i != l.length - 1) ? " + " : "";
//     }
//     return label;
//   }

//   String travelTimeFormat(String time) {
//     if (time == null) return "";
//     int hours = int.parse(time.split(":")[0]);
//     int minutes = int.parse(time.split(":")[1]);

//     return ("${hours}h ${minutes}m");
//   }
// }
