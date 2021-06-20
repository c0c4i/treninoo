import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton(
      {Key key,
      this.title,
      this.width = double.infinity,
      this.height = 54,
      this.color,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
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
        ));
  }
}
