import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';

class BeautifulCard extends StatelessWidget {
  final Widget child;

  const BeautifulCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
        side: BorderSide(
          color: Grey.light,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
