import 'package:flutter/material.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionsDetails extends StatelessWidget {
  final SolutionsInfo solutionsInfo;

  const SolutionsDetails({Key key, this.solutionsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
        color: Primary.normal,
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
            style: Typo.subheaderHeavy.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                formatDate(solutionsInfo.fromTime),
                style: Typo.subheaderLight.copyWith(color: Colors.white),
              ),
              Text(
                formatTime(solutionsInfo.fromTime),
                style: Typo.subheaderLight.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
