import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/cubit/predicted_arrival.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class PredictedArrival extends StatelessWidget {
  const PredictedArrival({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // if you need this
        side: BorderSide(
          color: Grey.light,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Arrivo predittivo",
                    style: Typo.subheaderHeavy,
                  ),
                  Text(
                    "Calcola automaticamente l’ora di arrivo in base al ritardo del treno",
                    style: Typo.bodyLight.copyWith(
                      color: Grey.dark,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoSwitch(
              value: context.watch<PredictedArrivalCubit>().state,
              onChanged: (bool value) {
                context.read<PredictedArrivalCubit>().setValue(value);
              },
              activeColor: Primary.normal,
            ),
          ],
        ),
      ),
    );
  }
}
