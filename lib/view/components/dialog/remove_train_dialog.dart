import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/buttons/dialog_button.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../../bloc/favourites/favourites.dart';
import '../../../bloc/recents/recents.dart';

// TODO Refactor to modal bottom sheet
class RemoveTrainDialog extends StatelessWidget {
  final SavedTrain savedTrain;
  final SavedTrainType savedTrainType;

  static void show(
    BuildContext context, {
    Key key,
    SavedTrain savedTrain,
    SavedTrainType savedTrainType,
  }) =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => RemoveTrainDialog(
          key: key,
          savedTrain: savedTrain,
          savedTrainType: savedTrainType,
        ),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  // static void hide(BuildContext context) => Navigator.pop(context);

  RemoveTrainDialog({
    Key key,
    this.savedTrain,
    this.savedTrainType,
  }) : super(key: key);

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
                  if (savedTrainType != null)
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
                            // TODO: Move to repository
                            // removeTrain(savedTrain, savedTrainType);
                            switch (savedTrainType) {
                              case SavedTrainType.recents:
                                context
                                    .read<RecentsBloc>()
                                    .add(RecentsRequest());
                                break;
                              case SavedTrainType.favourites:
                                context
                                    .read<FavouritesBloc>()
                                    .add(FavouritesRequest());
                                break;
                            }
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
