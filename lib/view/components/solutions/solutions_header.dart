import 'package:flutter/material.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/utils/core.dart';

class SolutionsDetails extends StatelessWidget {
  final SolutionsInfo solutionsInfo;

  const SolutionsDetails({Key key, this.solutionsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                formatDate(solutionsInfo.fromTime),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                formatTime(solutionsInfo.fromTime),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
