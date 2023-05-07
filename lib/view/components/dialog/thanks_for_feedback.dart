import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';
import '../../style/typography.dart';

class ThanksForFeedbackDialog {
  static show(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  Text(
                    "Grazie 🤩",
                    style: Typo.headlineHeavy,
                  ),
                  SizedBox(
                    height: kPadding * 2,
                    width: double.infinity,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/happy.gif",
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: kPadding * 2,
                    width: double.infinity,
                  ),
                  Text(
                    "Che sia un problema o un'idea, il tuo contributo è importante per migliorare Treninoo!",
                    style: Typo.subheaderLight,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
