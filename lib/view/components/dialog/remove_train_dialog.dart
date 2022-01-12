import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
import 'package:treninoo/view/components/buttons/dialog_button.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class RemoveTrainDialog extends StatelessWidget {
  final SavedTrain savedTrain;
  final SavedTrainType savedTrainType;
  final VoidCallback onConfirm;

  static void show(
    BuildContext context, {
    Key key,
    SavedTrain savedTrain,
    SavedTrainType savedTrainType,
    VoidCallback onConfirm,
  }) =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => RemoveTrainDialog(
          key: key,
          savedTrain: savedTrain,
          savedTrainType: savedTrainType,
          onConfirm: onConfirm,
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  // static void hide(BuildContext context) => Navigator.pop(context);

  RemoveTrainDialog(
      {Key key, this.savedTrain, this.savedTrainType, this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneWidth = MediaQuery.of(context).size.width;
    var dialogWidth = phoneWidth * 0.90;

    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(minWidth: 300, maxWidth: 340),
            width: dialogWidth,
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Treno non trovato",
                    style: Typo.titleHeavy,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Stato del treno non disponibile.\nVuoi rimuoverlo?",
                    style: Typo.subheaderLight.copyWith(color: Grey.dark),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      DialogButton(
                        title: "Annulla",
                        color: Grey.light,
                        textColor: Grey.darker,
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 10),
                      DialogButton(
                        title: "Rimuovi",
                        color: Primary.normal,
                        onPressed: () {
                          removeTrain(savedTrain, savedTrainType);
                          onConfirm();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
