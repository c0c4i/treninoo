import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class NotDepartedChip extends StatelessWidget {
  const NotDepartedChip({super.key});

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
          color: AppTheme.isDarkMode(context) ? Grey.lighter : Grey.lighter,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Non partito',
          style: Typo.captionLight.copyWith(
            color: AppTheme.isDarkMode(context)
                ? Color.lerp(Grey.normal, Colors.white, 0.1)
                : Grey.darker,
          ),
        ),
      ),
    );
  }
}
