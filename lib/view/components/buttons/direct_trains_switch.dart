import 'package:flutter/cupertino.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DirectTrainsSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const DirectTrainsSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kPadding / 2,
        horizontal: kPadding * 1.5,
      ),
      child: Column(
        children: [
          Text(
            "Solo diretti",
            style: Typo.bodyHeavy.copyWith(
              color: Grey.dark,
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Primary.normal,
          ),
        ],
      ),
    );
  }
}
