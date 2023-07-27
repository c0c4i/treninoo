import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';

class ActionTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? color;
  final VoidCallback? onPressed;

  const ActionTextButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 54,
    this.backgroundColor,
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
          foregroundColor: Grey.darker,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
      ),
    );
  }
}
