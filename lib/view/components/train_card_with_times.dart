import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:treninoo/bloc/exist/exist.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/description/description_footer.dart';
import 'package:treninoo/view/components/saved_train/pick_action.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../enum/saved_train_type.dart';

class TrainCardWithTimes extends StatelessWidget {
  final SavedTrain savedTrain;
  final SavedTrainType type;
  final bool enabled;

  const TrainCardWithTimes({
    Key? key,
    required this.savedTrain,
    required this.type,
    this.enabled = true,
  }) : super(key: key);

  String get semanticLabel {
    String label;
    if (savedTrain.trainType != null) {
      label = "Treno ${savedTrain.trainType} ${savedTrain.trainCode}";
    } else {
      label = "Treno ${savedTrain.trainCode}";
    }

    label +=
        ", Partenza ${savedTrain.departureTime} da ${savedTrain.departureStationName}";
    label +=
        ", Arrivo ${savedTrain.arrivalTime} a ${savedTrain.arrivalStationName}";
    return label + ".";
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(
          vertical: kPadding / 2,
          horizontal: 0,
        ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${savedTrain.trainType} ${savedTrain.trainCode}",
                        style: Typo.subheaderHeavy.copyWith(
                          color: Primary.normal,
                        ),
                      ),
                      SizedBox(height: kPadding / 2),
                      Row(
                        children: [
                          Text(
                            savedTrain.departureTime!,
                            style: GoogleFonts.robotoMono().copyWith(
                              fontSize: Typo.subheaderHeavy.fontSize,
                              fontWeight: Typo.subheaderHeavy.fontWeight,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: kPadding),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                savedTrain.departureStationName!.toUpperCase(),
                                style: Typo.subheaderHeavy.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kPadding / 2),
                      Row(
                        children: [
                          Text(
                            savedTrain.arrivalTime!,
                            style: GoogleFonts.robotoMono().copyWith(
                              fontSize: Typo.subheaderHeavy.fontSize,
                              fontWeight: Typo.subheaderHeavy.fontWeight,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: kPadding),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                savedTrain.arrivalStationName!.toUpperCase(),
                                style: Typo.subheaderHeavy.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (savedTrain.showSegmentCard)
                  SegmentSection(savedTrain: savedTrain),
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

class SegmentSection extends StatelessWidget {
  final SavedTrain savedTrain;

  const SegmentSection({Key? key, required this.savedTrain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Grey.lightest1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(kRadius),
          bottomRight: Radius.circular(kRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding,
        vertical: kPadding / 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tratto preferito",
            style: TextStyle(
              fontSize: 11,
              color: Primary.normal,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                savedTrain.selectedSegmentDepartureTime ?? '     ',
                style: GoogleFonts.robotoMono().copyWith(
                  fontSize: Typo.bodyHeavy.fontSize,
                  fontWeight: Typo.bodyHeavy.fontWeight,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: kPadding),
              Expanded(
                child: Text(
                  savedTrain.selectedSegmentDepartureStationName!.toUpperCase(),
                  style: Typo.bodyHeavy.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                savedTrain.selectedSegmentArrivalTime ?? '     ',
                style: GoogleFonts.robotoMono().copyWith(
                  fontSize: Typo.bodyHeavy.fontSize,
                  fontWeight: Typo.bodyHeavy.fontWeight,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: kPadding),
              Expanded(
                child: Text(
                  savedTrain.selectedSegmentArrivalStationName!.toUpperCase(),
                  style: Typo.bodyHeavy.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
