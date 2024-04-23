import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations/stations.dart';
import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/stations/station_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class FavouritesStationsList extends StatefulWidget {
  FavouritesStationsList({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(Station) onSelected;

  @override
  _FavouritesStationsListState createState() => _FavouritesStationsListState();
}

class _FavouritesStationsListState extends State<FavouritesStationsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        if (state is StationsSuccess && state.stations.length > 0) {
          List<SavedStation> favouriteStations =
              state.stations.where((element) => element.isFavourite).toList();

          return Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Stazioni preferite",
                  style: Typo.bodyHeavy.copyWith(
                    color: Grey.dark,
                  ),
                ),
                SizedBox(height: 8),
                Flexible(
                  child: BeautifulCard(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: favouriteStations.length,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          Divider(thickness: 1, height: 1),
                      itemBuilder: (context, index) {
                        return StationCard(
                          station: favouriteStations[index].station,
                          isFavourite: favouriteStations[index].isFavourite,
                          onPressed: () {
                            widget.onSelected(favouriteStations[index].station);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
