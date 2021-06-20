import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/button_type.dart';

class DialogButton extends StatelessWidget {
  final String title;
  final double height;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final ButtonType type;

  const DialogButton({
    Key key,
    this.title,
    this.height = 38,
    this.color,
    this.textColor = Colors.white,
    this.borderColor,
    this.onPressed,
    this.type = ButtonType.filled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.outlined)
      return Expanded(
        child: Container(
            height: height,
            child: OutlinedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: TextStyle(color: textColor),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).scaffoldBackgroundColor),
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            )),
      );

    return Expanded(
      child: Container(
          height: height,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(color: textColor),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  color ?? Theme.of(context).primaryColor),
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          )),
    );
  }
}
