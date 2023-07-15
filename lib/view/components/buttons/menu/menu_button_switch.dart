import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class MenuButtonSwitch extends StatelessWidget {
  const MenuButtonSwitch({
    Key? key,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String description;
  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // if you need this
        side: BorderSide(
          color: Grey.light,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.subheaderHeavy,
                  ),
                  Text(
                    description,
                    style: Typo.bodyLight.copyWith(
                      color: Grey.dark,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: Primary.normal,
            ),
          ],
        ),
      ),
    );
  }
}
