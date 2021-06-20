import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/train_card.dart';
import 'package:treninoo/view/components/trains_list.dart';

import '../pages/train_status_page.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';

class Recents extends StatefulWidget {
  Recents({Key key}) : super(key: key);

  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  List<SavedTrain> recents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Recenti", style: TextStyle(fontSize: 26)),
        ),
        SizedBox(height: 16),
        BlocBuilder<RecentsBloc, RecentsState>(
          builder: (context, state) {
            print(state);
            if (state is RecentsInitial)
              context.read<RecentsBloc>().add(RecentsRequest());
            if (state is RecentsSuccess) {
              return SavedTrainList(
                trains: state.trains,
                savedTrainType: SavedTrainType.recents,
              );
            }

            if (state is RecentsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is RecentsFailed) {}

            return Container();
          },
        ),
      ],
    );
  }

  // // preferito univoco
  // Widget _favouriteTrainWidget(SavedTrain train) {
  //   return TrainCard(
  //     train: train,
  //     onPressed: () async {
  //       var exist = await verifyIfTrainExist(
  //           train.departureStationCode, train.trainCode);

  //       if (exist) {
  //         // cercalo
  //         // Navigator.push(
  //         //   context,
  //         //   CupertinoPageRoute(
  //         //       builder: (context) => TrainStatusPage(
  //         //             trainCode: train.trainCode,
  //         //             stationCode: train.departureStationCode,
  //         //           )),
  //         // );
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: new Text("Treno mofidicato"),
  //               content: Text("Vuoi rimuoverlo dai recenti?"),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: Text("Elimina"),
  //                   onPressed: () {
  //                     // SharedPrefJson.nowSearching = train;
  //                     // SharedPrefJson.removeRecentTrain();
  //                     // print("elimino");
  //                     // setState(() {
  //                     //   widget.recents =
  //                     //       fetchSharedPreferenceWithListOf(spRecentsTrains);
  //                     // });
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 FlatButton(
  //                   child: Text("Annulla"),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     },
  //   );
  // }

  // void _showFutureReleaseDialog() {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Treni recenti"),
  //         content: new Text("La funzione sarà inserita nella prossima release"),
  //         titlePadding:
  //             EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
  //         contentPadding:
  //             EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //       );
  //     },
  //   );
  // }

}
