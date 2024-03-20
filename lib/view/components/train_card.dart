import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/description/description_footer.dart';
import 'package:treninoo/view/components/saved_train/pick_action.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../enum/saved_train_type.dart';

class TrainCard extends StatelessWidget {
  final SavedTrain savedTrain;
  final SavedTrainType type;
  final bool enabled;

  const TrainCard({
    Key? key,
    required this.savedTrain,
    required this.type,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: OutlinedButton(
          onPressed: enabled
              ? () {
                  context
                      .read<ExistBloc>()
                      .add(ExistRequest(savedTrain: savedTrain, type: type));
                }
              : null,
          onLongPress: enabled
              ? () {
                  SavedTrainPickAction.show(
                    context: context,
                    savedTrain: savedTrain,
                    type: type,
                  );
                }
              : null,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: kPadding,
                    left: kPadding,
                    right: kPadding,
                    bottom:
                        savedTrain.description != null ? kPadding : kPadding,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${savedTrain.trainType} ${savedTrain.trainCode}",
                              style: Typo.subheaderHeavy.copyWith(
                                color: Primary.normal,
                              ),
                            ),
                          ),
                          Text(
                            savedTrain.departureTime ?? '',
                            style: Typo.subheaderHeavy.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 16),
                          Text(
                            savedTrain.departureStationName ?? '',
                            style: Typo.subheaderHeavy.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.only(left: 11),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          color: Primary.normal,
                          width: 1,
                          height: 8,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 16),
                          Text(
                            savedTrain.arrivalStationName ?? '',
                            style: Typo.subheaderHeavy.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                if (savedTrain.description != null)
                  DescriptionFooter(description: savedTrain.description)
              ],
            ),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
