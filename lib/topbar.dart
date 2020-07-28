import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'settings.dart';

class TopBar extends StatelessWidget {
  TopBar({Key key, this.text, this.location}) : super(key: key);
  final String text;
  final int location;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            OMIcons.train,
            size: 40.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '$text',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment(1, 0.5),
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  if(location == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings()
                      ),
                    );
                  } else {
                    // salva
                  }
                    
                },
                icon: location == 0
                ? Icon(
                  OMIcons.settings,
                )
                : Icon(
                  Icons.bookmark_border,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}