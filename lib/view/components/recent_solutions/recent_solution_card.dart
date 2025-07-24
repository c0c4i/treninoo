import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedSolutionsInfo.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class RecentSolutionCard extends StatelessWidget {
  final SavedSolutionsInfo solutionsInfo;
  final VoidCallback onPressed;
  final VoidCallback onSearch;

  const RecentSolutionCard({
    super.key,
    required this.solutionsInfo,
    required this.onPressed,
    required this.onSearch,
  });

  final double height = 52;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            label:
                "Partenza: ${solutionsInfo.departureStation.stationName} Arrivo: ${solutionsInfo.arrivalStation.stationName}",
            excludeSemantics: true,
            button: true,
            child: SizedBox(
              height: height,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadius / 2),
                  ),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                onPressed: onPressed,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadding,
                    vertical: kPadding,
                  ),
                  child: Text(
                    "${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
                    style: Typo.subheaderHeavy.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 20,
          child: VerticalDivider(
            width: 2,
            thickness: 1,
            color: Grey.normal,
          ),
        ),
        Semantics(
          label:
              "Cerca soluzione per ${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
          excludeSemantics: true,
          button: true,
          child: SizedBox(
            width: height,
            height: height,
            child: TextButton(
              onPressed: onSearch,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                Icons.search,
                color: Primary.normal,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
