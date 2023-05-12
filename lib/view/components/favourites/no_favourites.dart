import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class NoFavourites extends StatelessWidget {
  const NoFavourites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no_favourites.png',
          height: 116,
        ),
        SizedBox(height: kPadding),
        Text(
          "Non ci sono preferiti",
          style: Typo.headlineHeavy,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Salva i tuoi treni preferiti cliccando l’icona",
              style: Typo.subheaderLight.copyWith(color: Grey.dark),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 2),
            Icon(
              Icons.favorite_border_rounded,
              color: Grey.dark,
              size: 16,
            ),
          ],
        ),
      ],
    );
  }
}
