import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class RailChip extends StatelessWidget {
  const RailChip({super.key, this.rail, this.confirmed = false});

  final String? rail;
  final bool confirmed;

  get railTitle => confirmed ? rail : "provvisorio";
  get railTextColor => confirmed ? Colors.blue : Grey.darker;
  get railColor => confirmed ? Colors.blue.withOpacity(0.1) : Grey.lighter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: railColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              Icons.tag,
              color: railTextColor,
              size: 16,
            ),
            SizedBox(width: kPadding / 2),
            Text(
              rail ?? "-",
              style: Typo.subheaderHeavy.copyWith(
                color: railTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
