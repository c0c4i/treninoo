import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/typography.dart';

class BeautifulAppBar extends StatelessWidget {
  const BeautifulAppBar({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            title!,
            style: Typo.headlineHeavy.copyWith(color: Primary.normal),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
