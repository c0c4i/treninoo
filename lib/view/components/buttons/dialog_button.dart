import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DialogButton extends StatelessWidget {
  final String title;
  final double height;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;

  const DialogButton({
    Key key,
    this.title,
    this.height = 48,
    this.color,
    this.textColor = Colors.white,
    this.borderColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: Typo.subheaderHeavy.copyWith(color: textColor),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: color ?? Primary.normal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
          ),
        ),
      ),
    );
  }
}
