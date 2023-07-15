import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/style/typography.dart';

class StationSuggestion extends StatelessWidget {
  final Station? station;

  const StationSuggestion({
    Key? key,
    required this.station,
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
              station!.stationName!,
              style: Typo.subheaderHeavy,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
