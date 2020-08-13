import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:treninoo/utils.dart';
import 'settings.dart';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:treninoo/treninoo_icons.dart';

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
            OMIcons.train,
            size: 40.0,
          ),
          // Icon(TreninooIcon.treninoo_03),
          // svgIcon,
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
                      MaterialPageRoute(builder: (context) => Settings()),
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

  if (SharedPrefJson.isFavourite()) return Icon(Icons.bookmark);

  return Icon(Icons.bookmark_border);
}
