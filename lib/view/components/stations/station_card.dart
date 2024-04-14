import 'package:flutter/material.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class StationCard extends StatelessWidget {
  final Station station;
  final bool isFavourite;
  final VoidCallback? onPressed;
  final VoidCallback? onFavorite;

  const StationCard({
    Key? key,
    required this.station,
    this.isFavourite = false,
    this.onPressed,
    this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Row(
          children: [
            Expanded(
              child: Text(
                station.stationName,
                style: Typo.subheaderHeavy.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            if (onFavorite != null)
              IconButton(
                onPressed: onFavorite,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  isFavourite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavourite
                      ? Primary.normal
                      : Theme.of(context).iconTheme.color,
                ),
              ),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
