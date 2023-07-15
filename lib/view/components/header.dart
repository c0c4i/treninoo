import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.title, this.description}) : super(key: key);

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            title!,
            style: Typo.displayHeavy,
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
