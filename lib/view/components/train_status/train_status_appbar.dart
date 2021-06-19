import 'package:flutter/material.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/shared_preference.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/button.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainAppBar extends StatefulWidget {
  final String number;
  final TrainInfo trainInfo;

  const TrainAppBar({Key key, this.number, this.trainInfo}) : super(key: key);

  @override
  _TrainAppBarState createState() => _TrainAppBarState();
}

class _TrainAppBarState extends State<TrainAppBar> {
  IconData rigthIcon;

  @override
  void initState() {
    rigthIcon = pickIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            widget.number,
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        widget.trainInfo != null
            ? IconButton(
                iconSize: 40,
                onPressed: () {
                  if (isFavouriteTrain(widget.trainInfo)) {
                    removeFavouriteTrain(widget.trainInfo);
                  } else {
                    addFavouriteTrain(widget.trainInfo);
                  }

                  setState(() {
                    rigthIcon = pickIcon();
                  });
                },
                icon: Icon(
                  pickIcon(),
                  size: 35,
                  color: AppColors.red,
                ),
              )
            : Container(),
      ],
    );
  }

  IconData pickIcon() {
    if (widget.trainInfo == null) return Icons.favorite_border_rounded;
    if (isFavouriteTrain(widget.trainInfo))
      return Icons.favorite_rounded;
    else
      return Icons.favorite_border_rounded;
  }
}
