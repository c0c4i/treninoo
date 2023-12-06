import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainInfoDetails extends StatelessWidget {
  final TrainInfo trainInfo;

  const TrainInfoDetails({Key? key, required this.trainInfo}) : super(key: key);

  get isDeparted {
    return trainInfo.lastPositionRegister != '--';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Primary.normal,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isDeparted
                      ? [
                          Text(
                            '${trainInfo.lastPositionRegister}',
                            style:
                                Typo.titleHeavy.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Ultimo Rilevamento: ${trainInfo.lastTimeRegister!.format(context)}',
                            style: Typo.bodyLight.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ]
                      : [
                          Text(
                            'Non ancora partito',
                            style:
                                Typo.titleHeavy.copyWith(color: Colors.white),
                          ),
                        ],
                )),
            Expanded(
              flex: 1,
              child: Text(
                delay,
                textAlign: TextAlign.right,
                style: Typo.subheaderLight.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get delay {
    String text = trainInfo.delay! < 0 ? 'Anticipo' : 'Ritardo';
    return text + " ${trainInfo.delay}\'";
  }
}
