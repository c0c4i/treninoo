import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/cubit/predicted_arrival.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/accent.dart';
import '../../style/colors/grey.dart';
import '../../style/colors/primary.dart';
import '../../style/typography.dart';
import '../buttons/dialog_button.dart';

class BeautifulNewFeatureDialog {
  static Future<void> show({
    required BuildContext context,
  }) async =>
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
        ),
        builder: (_) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPadding * 2),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "Nuova modalità predittiva",
                        style: Typo.titleHeavy,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.auto_awesome_outlined,
                        color: Accent.normal,
                      ),
                    ],
                  ),
                  SizedBox(height: kPadding / 2),
                  Text(
                    "Permette di vedere automaticamente l’orario reale di arrivo in base al ritardo attuale",
                    style: Typo.subheaderLight.copyWith(color: Grey.dark),
                  ),
                  SizedBox(height: 8, width: double.infinity),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // if you need this
                      side: BorderSide(
                        color: Grey.light,
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      "assets/predictive_arrival_example.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: kPadding, width: double.infinity),
                  Row(
                    children: [
                      DialogButton(
                        title: "Annulla",
                        color: Grey.light,
                        textColor: Grey.darker,
                        onPressed: () {
                          context.read<PredictedArrivalCubit>().setValue(false);
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: kPadding),
                      DialogButton(
                          title: "Attiva",
                          color: Primary.normal,
                          onPressed: () {
                            context
                                .read<PredictedArrivalCubit>()
                                .setValue(true);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  SizedBox(height: kPadding),
                  Text(
                    "Potrai disattivare la funzionalità dalle impostazioni",
                    style: Typo.subheaderLight.copyWith(color: Grey.dark),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
