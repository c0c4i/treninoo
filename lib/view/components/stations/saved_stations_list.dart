import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations/stations.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/stations/station_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class SavedStationsList extends StatefulWidget {
  SavedStationsList({Key? key, required this.onSelected}) : super(key: key);

  final Function(Station) onSelected;

  @override
  _SavedStationsListState createState() => _SavedStationsListState();
}

class _SavedStationsListState extends State<SavedStationsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // On scroll hide keyboard
    _scrollController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationsBloc, StationsState>(
      builder: (context, state) {
        if (state is StationsSuccess && state.stations.length > 0) {
          return Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Icon(Icons.favorite_rounded, size: 16, color: Grey.dark),
                    SizedBox(width: 6),
                    Text(
                      "Stazioni preferite e recenti",
                      style: Typo.bodyHeavy.copyWith(color: Grey.dark),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Flexible(
                  child: BeautifulCard(
                    child: ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: state.stations.length,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          Divider(thickness: 1, height: 1),
                      itemBuilder: (context, index) {
                        return StationCard(
                          station: state.stations[index].station,
                          isFavourite: state.stations[index].isFavourite,
                          onPressed: () {
                            widget.onSelected(state.stations[index].station);
                          },
                          onFavorite: () {
                            context.read<StationsBloc>().add(
                                  UpdateFavorite(
                                    savedStation: state.stations[index],
                                  ),
                                );
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
