import 'package:flutter/material.dart';
import 'package:treninoo/view/style/typography.dart';

class SuggestionRow extends StatelessWidget {
  final String suggestion;

  const SuggestionRow({
    Key key,
    this.suggestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              suggestion,
              style: Typo.subheaderHeavy,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
