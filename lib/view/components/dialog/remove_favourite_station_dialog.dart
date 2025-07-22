import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/view/style/theme.dart';
import '../../style/colors/grey.dart';
import '../../style/colors/primary.dart';
import '../../style/typography.dart';
import '../buttons/dialog_button.dart';

class RemoveFavouriteStationDialog {
  static show<bool>(
    BuildContext context, {
    required SavedStation savedStation,
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
                      "Vuoi rimuovere?",
                      style: Typo.titleHeavy,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${savedStation.station.stationName} sarà rimossa dalle tue stazioni preferite.",
                      style: Typo.subheaderLight.copyWith(color: Grey.dark),
                    ),
                    SizedBox(height: kPadding),
                    Divider(thickness: 1, height: 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: kPadding),
                        // Text(
                        //   "Desideri rimuoverlo dai ${getSavedTrainTypeLabel(savedTrainType)}?",
                        //   style:
                        //       Typo.subheaderLight.copyWith(color: Grey.dark),
                        // ),
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
                        ),
                        SizedBox(height: kPadding),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ) ??
      false;
}
