import 'package:flutter/material.dart';
import 'package:treninoo/utils/delay.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DelayChip extends StatelessWidget {
  const DelayChip({super.key, this.delay});

  final int? delay;

  get delayTitle => DelayUtils.title(delay);
  get delayColor => DelayUtils.color(delay);

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
          color: delayColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          delayTitle!,
          style: Typo.captionLight.copyWith(
            color: DelayUtils.textColor(
              delay,
              AppTheme.isDarkMode(context),
            ),
          ),
        ),
      ),
    );
  }
}
