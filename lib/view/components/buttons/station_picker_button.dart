import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class StationPickerButton extends StatelessWidget {
  final String title;
  final String? content;
  final VoidCallback onPressed;

  const StationPickerButton({
    Key? key,
    required this.title,
    this.content = "-",
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kPadding * 2 / 3,
          horizontal: kPadding,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Typo.bodyHeavy.copyWith(
                  color: Grey.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content!,
                style: Typo.subheaderHeavy.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        backgroundColor: Theme.of(context).cardColor,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
