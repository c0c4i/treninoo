import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';
import '../../../enum/saved_train_type.dart';
import '../../../model/SavedTrain.dart';
import '../../style/colors/grey.dart';
import '../../style/colors/primary.dart';
import '../../style/typography.dart';
import '../buttons/dialog_button.dart';

class TrainNotFoundDialog {
  static show<bool>(
    BuildContext context, {
    required SavedTrain? savedTrain,
    required SavedTrainType? savedTrainType,
  }) async =>
      await showModalBottomSheet<bool>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (_) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: kPadding * 2,
                left: kPadding * 2,
                right: kPadding * 2,
                // bottom: kPadding,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Treno non trovato",
                      style: Typo.titleHeavy,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Lo stato del treno non è al momento disponibile, potrebbe esserci un problema al treno.",
                      style: Typo.subheaderLight.copyWith(color: Grey.dark),
                    ),
                    SizedBox(height: kPadding),
                    Divider(thickness: 1, height: 1),
                    if (savedTrainType != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: kPadding),
                          Text(
                            "Desideri rimuoverlo dai ${getSavedTrainTypeLabel(savedTrainType)}?",
                            style:
                                Typo.subheaderLight.copyWith(color: Grey.dark),
                          ),
                          SizedBox(height: kPadding),
                          Row(
                            children: [
                              DialogButton(
                                title: "Annulla",
                                color: Grey.light,
                                textColor: Grey.darker,
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              SizedBox(width: kPadding),
                              DialogButton(
                                title: "Rimuovi",
                                color: Primary.normal,
                                onPressed: () => Navigator.pop(context, true),
                              ),
                            ],
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
