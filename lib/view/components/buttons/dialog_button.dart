import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

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
    this.height = 38,
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
            style: TextStyle(color: textColor),
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: color ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadius),
            ),
          ),
        ),
      ),
    );
  }
}
