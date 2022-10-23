import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    Key key,
    this.title,
    this.width = double.infinity,
    this.height = 54,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color ?? Primary.normal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
      ),
    );
  }
}
