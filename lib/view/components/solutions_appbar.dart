import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';

class SolutionsAppBar extends StatefulWidget {
  const SolutionsAppBar({Key key}) : super(key: key);

  @override
  _SolutionsAppBarState createState() => _SolutionsAppBarState();
}

class _SolutionsAppBarState extends State<SolutionsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Text(
          "Soluzioni",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
