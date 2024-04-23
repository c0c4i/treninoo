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

  bool get toggleFavourite => onFavorite != null;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: toggleFavourite ? kPadding : kPadding * 1.2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                label: station.stationName,
                excludeSemantics: true,
                button: true,
                child: Text(
                  station.stationName,
                  style: Typo.subheaderHeavy.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
            if (toggleFavourite)
              Semantics(
                label: isFavourite
                    ? "Rimuovi ${station.stationName} dai preferiti"
                    : "Aggiungi ${station.stationName} ai preferiti",
                excludeSemantics: true,
                button: true,
                child: IconButton(
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
