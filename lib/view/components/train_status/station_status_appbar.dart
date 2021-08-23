import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';
import 'package:treninoo/view/style/theme.dart';

class StationAppBar extends StatefulWidget {
  final String stationName;

  const StationAppBar({Key key, this.stationName}) : super(key: key);

  @override
  _StationAppBarState createState() => _StationAppBarState();
}

class _StationAppBarState extends State<StationAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            widget.stationName,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
