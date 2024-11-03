import 'package:flutter/material.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/delay.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainInfoDetails extends StatelessWidget {
  final TrainInfo trainInfo;

  const TrainInfoDetails({Key? key, required this.trainInfo}) : super(key: key);

  get isDeparted {
    return trainInfo.lastPositionRegister != '--';
  }

  semanticLabel(context) {
    if (!isDeparted) return "Treno non ancora partito";

    if (trainInfo.delay != null && trainInfo.delay! > 0) {
      if (trainInfo.lastTimeRegister == null) {
        return "Ultimo rilevamento a ${trainInfo.lastPositionRegister} con un ritardo di ${trainInfo.delay} minuti";
      }
      return "Ultimo rilevamento a ${trainInfo.lastPositionRegister} alle ore ${trainInfo.lastTimeRegister!.format(context)} con un ritardo di ${trainInfo.delay} minuti";
    }

    if (trainInfo.lastTimeRegister == null) {
      return "Ultimo rilevamento a ${trainInfo.lastPositionRegister}, treno in orario.";
    }

    return "Ultimo rilevamento a ${trainInfo.lastPositionRegister} alle ore ${trainInfo.lastTimeRegister!.format(context)}, treno in orario.";
  }

  get delayDescription => DelayUtils.description(trainInfo.delay);
  get delayTextColor => DelayUtils.textColor(trainInfo.delay);
  get delayColor => DelayUtils.color(trainInfo.delay);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kRadius),
          border: Border.all(
            color: Grey.light,
            width: 1,
          ),
        ),
        child: Semantics(
          label: semanticLabel(context),
          excludeSemantics: true,
          child: Row(
            children: <Widget>[
              Expanded(
                child: isDeparted
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            if (trainInfo.lastPositionRegister != null)
                              Text(
                                trainInfo.lastPositionRegister!,
                                style: Typo.titleHeavy.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            Text(
                              'Ultimo Rilevamento: ${trainInfo.lastTimeRegister!.format(context)}',
                              style: Typo.bodyLight.copyWith(
                                color: Grey.dark,
                              ),
                            ),
                          ])
                    : Semantics(
                        label: "Treno non ancora partito",
                        excludeSemantics: true,
                        child: Text(
                          'Non ancora partito',
                          style: Typo.titleHeavy.copyWith(color: Colors.black),
                        ),
                      ),
              ),
              if (isDeparted)
                Semantics(
                  label: "${delayDescription}: ${trainInfo.delay} minuti",
                  excludeSemantics: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: delayColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Column(
                      children: [
                        Text(
                          trainInfo.delay!.abs().toString(),
                          style: Typo.headlineHeavy.copyWith(
                            color: delayTextColor,
                          ),
                        ),
                        Text(
                          delayDescription,
                          style: Typo.subheaderLight.copyWith(
                            color: delayTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
