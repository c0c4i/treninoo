import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class RailChip extends StatefulWidget {
  const RailChip({super.key, this.rail, this.confirmed = false});

  final String? rail;
  final bool confirmed;

  @override
  State<RailChip> createState() => _RailChipState();
}

class _RailChipState extends State<RailChip> {
  get railTitle => widget.confirmed ? widget.rail : "provvisorio";

  get railTextColor {
    if (widget.confirmed) return Colors.blue;
    return AppTheme.isDarkMode(context)
        ? Color.lerp(Grey.normal, Colors.white, 0.1)
        : Grey.darker;
  }

  get railColor {
    bool isDarkMode = AppTheme.isDarkMode(context);

    if (widget.confirmed) {
      return Colors.blue.withOpacity(
        isDarkMode ? 0.2 : 0.1,
      );
    }

    return isDarkMode ? Grey.lighter : Grey.lighter;
  }

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
              widget.rail ?? "-",
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
