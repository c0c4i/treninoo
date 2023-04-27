import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../style/theme.dart';

class PickActionRow extends StatelessWidget {
  const PickActionRow({
    Key key,
    @required this.icon,
    @required this.data,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Primary.normal,
      ),
      minLeadingWidth: 24,
      title: Text(
        data,
        style: Typo.subheaderHeavy,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      // child: Row(
      //   children: [
      //     Icon(
      //       Icons.subject_rounded,
      //       color: Primary.normal,
      //     ),
      //     Expanded(
      //       child: Text(
      //         data,
      //         style: Typo.subheaderHeavy,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
