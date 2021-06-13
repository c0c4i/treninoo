import 'package:flutter/material.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/button.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainAppBar extends StatefulWidget {
  final String number;

  const TrainAppBar({Key key, this.number}) : super(key: key);

  @override
  _TrainAppBarState createState() => _TrainAppBarState();
}

class _TrainAppBarState extends State<TrainAppBar> {
  Icon rigthIcon;

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
        IconButton(
          iconSize: 40,
          onPressed: () {
            if (SharedPrefJson.isFavourite()) {
              SharedPrefJson.removeFavourite();
            } else {
              SharedPrefJson.addFavourite();
            }

            setState(() {
              rigthIcon = pickIcon();
            });
          },
          icon: rigthIcon,
        ),
      ],
    );
  }
}

Icon pickIcon() {
  double size = 35.0;
  IconData icon;

  if (SharedPrefJson.isFavourite())
    icon = Icons.favorite;
  else
    icon = Icons.favorite_border;

  return Icon(
    icon,
    size: size,
    color: AppColors.red,
  );
}
