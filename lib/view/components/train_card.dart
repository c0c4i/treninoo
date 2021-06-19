import 'package:flutter/material.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainCard extends StatelessWidget {
  final SavedTrain train;
  // final String number;
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  const TrainCard({
    Key key,
    this.train,
    // this.number,
    this.width = double.infinity,
    this.height = 50,
    this.color,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        width: width,
        child: ElevatedButton(
          // onPressed: onPressed,
          onPressed: () {
            Navigator.pushNamed(context, RoutesNames.status, arguments: train);
          },
          onLongPress: onLongPress,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      train.trainType + " " + train.trainCode,
                      style: TextStyle(
                          color: AppColors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    train.departureTime,
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
                    train.departureStationName,
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
                    train.arrivalStationName,
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                color ?? Theme.of(context).scaffoldBackgroundColor),
            elevation: MaterialStateProperty.all<double>(4),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(16)),
          ),
        ));
  }
}
