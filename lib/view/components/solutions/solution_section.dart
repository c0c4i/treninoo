import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionSection extends StatelessWidget {
  final TrainSolution trainSolution;
  final int position;
  final int size;

  const SolutionSection({Key key, this.trainSolution, this.position, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      // onPressed: onPressed,
      onPressed: () {
        // Navigator.pushNamed(context, RoutesNames.status, arguments: train);
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trainSolution.trainType + " " + trainSolution.trainCode,
                  style: TextStyle(
                      color: AppColors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                travelTime(
                    trainSolution.departureTime, trainSolution.arrivalTime),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              Text(
                trainSolution.departureStation,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(left: 11),
            alignment: Alignment.centerLeft,
            child: Container(
              color: Theme.of(context).primaryColor,
              width: 1,
              height: 16,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              Text(
                trainSolution.arrivalStation,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              )
            ],
          ),
        ],
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius(),
        ),
        padding: EdgeInsets.all(16),
      ),
    ));
  }

  BorderRadius getBorderRadius() {
    if (size == 1) return BorderRadius.circular(16);
    if (position == 0)
      return BorderRadius.vertical(
          top: Radius.circular(16), bottom: Radius.zero);
    if (position == size - 1)
      return BorderRadius.vertical(
          bottom: Radius.circular(16), top: Radius.zero);
    return BorderRadius.zero;
  }
}
