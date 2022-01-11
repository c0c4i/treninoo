import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

class BeautifulBackButton extends StatelessWidget {
  const BeautifulBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
      ),
    );
  }
}
