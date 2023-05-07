import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color color;
  final VoidCallback onPressed;
  final bool isLoading;

  const ActionButton({
    Key key,
    this.title,
    this.width = double.infinity,
    this.height = 54,
    this.backgroundColor,
    this.color,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: !isLoading ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
        style: TextButton.styleFrom(
          foregroundColor: color ?? Colors.white,
          backgroundColor: backgroundColor ?? Primary.normal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          disabledForegroundColor: color ?? Colors.white,
        ),
      ),
    );
  }
}
