import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainInfoStopsHeader extends StatelessWidget {
  const TrainInfoStopsHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TrainStatusStopsHeaderCell(title: "Stazione"),
          ),
          Expanded(
            flex: 1,
            child: TrainStatusStopsHeaderCell(title: "Bin."),
          ),
          Expanded(
            flex: 2,
            child: TrainStatusStopsHeaderCell(title: "Arrivo"),
          ),
          Expanded(
            flex: 2,
            child: TrainStatusStopsHeaderCell(title: "Partenza"),
          ),
        ],
      ),
    );
  }
}

class TrainStatusStopsHeaderCell extends StatelessWidget {
  const TrainStatusStopsHeaderCell({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Typo.subheaderLight.copyWith(color: Grey.dark),
      textAlign: TextAlign.center,
    );
  }
}
