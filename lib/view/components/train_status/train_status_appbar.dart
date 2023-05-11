import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';
import 'package:treninoo/view/style/colors/primary.dart';

class TrainAppBar extends StatefulWidget {
  final String number;
  final TrainInfo trainInfo;

  const TrainAppBar({Key key, this.number, this.trainInfo}) : super(key: key);

  @override
  _TrainAppBarState createState() => _TrainAppBarState();
}

class _TrainAppBarState extends State<TrainAppBar> {
  IconData rigthIcon;

  @override
  void initState() {
    rigthIcon = pickIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            widget.number,
            style: TextStyle(
              fontSize: 26,
              color: Primary.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        widget.trainInfo != null
            ? Row(
                children: [
                  // TODO: Implement notification in app
                  // IconButton(
                  //   iconSize: 40,
                  //   onPressed: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       RoutesNames.followTrainStations,
                  //       arguments: DepartureStation(
                  //         station: Station(
                  //           stationName: widget.trainInfo.departureStationName,
                  //           stationCode: widget.trainInfo.departureStationCode,
                  //         ),
                  //         trainCode: widget.trainInfo.trainCode,
                  //       ),
                  //     );
                  //   },
                  //   icon: Icon(
                  //     Icons.notifications_none_rounded,
                  //     size: 35,
                  //     color: Primary.normal,
                  //   ),
                  // ),
                  IconButton(
                    iconSize: 40,
                    onPressed: () {
                      // TODO: Refactor to repository
                      // if (isFavouriteTrain(widget.trainInfo)) {
                      //   removeTrain(
                      //     SavedTrain.fromTrainInfo(widget.trainInfo),
                      //     SavedTrainType.favourites,
                      //   );
                      // } else {
                      //   addTrain(
                      //     SavedTrain.fromTrainInfo(widget.trainInfo),
                      //     SavedTrainType.favourites,
                      //   );
                      // }

                      setState(() {
                        rigthIcon = pickIcon();
                      });
                    },
                    icon: Icon(
                      pickIcon(),
                      size: 35,
                      color: Primary.normal,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  IconData pickIcon() {
    return Icons.favorite_border_rounded;
    // TODO: Refactor to repository
    // if (widget.trainInfo == null) return Icons.favorite_border_rounded;
    // if (isFavouriteTrain(widget.trainInfo))
    //   return Icons.favorite_rounded;
    // else
    //   return Icons.favorite_border_rounded;
  }
}
