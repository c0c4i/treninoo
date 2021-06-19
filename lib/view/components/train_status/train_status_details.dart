import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainInfo.dart';

class TrainInfoDetails extends StatelessWidget {
  final TrainInfo trainInfo;

  const TrainInfoDetails({Key key, this.trainInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (trainInfo.lastPositionRegister == '--')
                          ? 'Non ancora partito'
                          : '${trainInfo.lastPositionRegister}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    (trainInfo.lastPositionRegister == '--')
                        ? SizedBox.shrink()
                        : Text(
                            'Ultimo Rilevamento: ${trainInfo.lastTimeRegister}',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Text(
                pickDelay(trainInfo.delay),
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String pickDelay(int delay) {
    String text = delay < 0 ? 'Anticipo' : 'Ritardo';
    return text + " $delay\'";
  }
}
