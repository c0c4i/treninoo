import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class WaitingTimeCard extends StatelessWidget {
  const WaitingTimeCard({super.key, required this.travelTime});

  final String travelTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kPadding,
      ),
      decoration: BoxDecoration(
        color: Grey.lighter,
        borderRadius: BorderRadius.circular(kRadius / 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kPadding / 2,
          horizontal: kPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.swap_horiz_rounded,
              color: Grey.darker,
              size: 20,
              opticalSize: 20,
            ),
            SizedBox(width: kPadding / 2),
            Text(
              travelTime,
              style: Typo.subheaderHeavy.copyWith(
                color: Grey.darker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
