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

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding,
        ),
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                label:
                    "Partenza: ${solutionsInfo.departureStation.stationName} Arrivo: ${solutionsInfo.arrivalStation.stationName}",
                excludeSemantics: true,
                button: true,
                child: Text(
                  "${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
                  style: Typo.subheaderHeavy.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              height: 20,
              width: 20,
              child: VerticalDivider(
                width: 2,
                thickness: 1,
                color: Grey.normal,
              ),
            ),
            // GestureDetector(
            //   onTap: onSearch,
            //   child: Icon(
            //     Icons.search,
            //     color: Primary.normal,
            //   ),
            // )
            Semantics(
              label:
                  "Cerca soluzione per ${solutionsInfo.departureStation.stationName} - ${solutionsInfo.arrivalStation.stationName}",
              excludeSemantics: true,
              button: true,
              child: IconButton(
                onPressed: onSearch,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                splashColor: Primary.lighter,
                highlightColor: Primary.lighter,
                splashRadius: 16,
                icon: Icon(
                  Icons.search,
                  color: Primary.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
