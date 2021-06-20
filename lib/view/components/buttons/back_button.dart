import 'package:flutter/material.dart';

class BeautifulBackButton extends StatelessWidget {
  const BeautifulBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Center(
            child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Theme.of(context).primaryColor,
        )),
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onSurface: Colors.green,
        ),
      ),
    );
  }
}
