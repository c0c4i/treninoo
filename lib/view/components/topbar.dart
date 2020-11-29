import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:treninoo/view/pages/Settings.dart';
import 'package:treninoo/view/style/treninoo_icon_icons.dart';

import 'package:treninoo/utils/utils.dart';

class TopBar extends StatefulWidget {
  TopBar({Key key, this.text, this.location}) : super(key: key);
  final String text;
  final int location;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  Icon rigthIcon;

  @override
  Widget build(BuildContext context) {
    setState(() {
      rigthIcon = pickIcon(widget.location);
    });

    // final String assetName = 'treninoo-03.svg';
    // final Widget svgIcon = SvgPicture.asset(assetName,
    //     color: Colors.red, semanticsLabel: 'A red up arrow');

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            // OMIcons.train,
            TreninooIcon.treninoo_black_02_02,
            size: 40.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '${widget.text}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment(1, 0.5),
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  if (widget.location == 0) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Settings()),
                    );
                  } else {
                    // salva prendendoti il numero del treno
                    // prova dura aggiungendo ai preferiti anche se c'è già
                    if (SharedPrefJson.isFavourite()) {
                      SharedPrefJson.removeFavourite();
                    } else {
                      SharedPrefJson.addFavourite();
                    }

                    setState(() {
                      rigthIcon = pickIcon(widget.location);
                    });
                  }
                },
                icon: rigthIcon,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Icon pickIcon(int l) {
  if (l == 0) return Icon(OMIcons.settings);
  double size = 35.0;
  IconData icon;

  if (SharedPrefJson.isFavourite())
    icon = Icons.favorite;
  else
    icon = Icons.favorite_border;

  return Icon(
    icon,
    size: size,
  );
}
