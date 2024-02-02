import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    this.title,
    this.description,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final String? description;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                title!,
                style: Typo.displayHeavy,
              ),
              if (icon != null)
                Row(
                  children: [
                    SizedBox(width: kPadding / 2),
                    Container(
                      // Circle container
                      decoration: BoxDecoration(
                        color: Primary.lightest2,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          icon,
                          size: 18,
                          color: Primary.normal,
                        ),
                        constraints: BoxConstraints(),
                        onPressed: onPressed,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            width: 300,
            child: Text(
              description!,
              style: Typo.subheaderLight.copyWith(color: Grey.dark),
            ),
          ),
        ],
      ),
    );
  }
}
