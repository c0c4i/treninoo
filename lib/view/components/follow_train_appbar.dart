import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';

class FollowTrainAppBar extends StatefulWidget {
  const FollowTrainAppBar({Key key}) : super(key: key);

  @override
  _FollowTrainAppBarState createState() => _FollowTrainAppBarState();
}

class _FollowTrainAppBarState extends State<FollowTrainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Text(
          "Segui il treno",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
