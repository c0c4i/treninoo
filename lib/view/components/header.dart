import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

class Header extends StatelessWidget {
  const Header({Key key, this.title, this.description}) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          Container(
            width: 300,
            child: Text(
              description,
              style: TextStyle(color: AppColors.secondaryGrey),
            ),
          ),
        ],
      ),
    );
  }
}
