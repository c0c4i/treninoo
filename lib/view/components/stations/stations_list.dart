import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations/stations.dart';
import 'package:treninoo/bloc/stations_autocomplete/stations_autocomplete.dart';
import 'package:treninoo/model/SavedStation.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/stations/station_card.dart';

class StationsList extends StatefulWidget {
  final Function(Station) onSelected;

  StationsList({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<StationsList> createState() => _StationsListState();
}

class _StationsListState extends State<StationsList> {
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
    return BlocBuilder<StationsAutocompleteBloc, StationsAutocompleteState>(
      builder: (context, state) {
        if (state is StationsAutocompleteSuccess) {
          return Flexible(
            flex: 1,
            child: BeautifulCard(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: state.stations.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isFavourite = false;
                  final stationsState = context.read<StationsBloc>().state;
                  if (context.watch<StationsBloc>().state is StationsSuccess) {
                    isFavourite =
                        (stationsState as StationsSuccess).stations.any((s) {
                      String stationCode = state.stations[index].stationCode;
                      return s.station.stationCode == stationCode &&
                          s.isFavourite;
                    });
                  }

                  return StationCard(
                    station: state.stations[index],
                    onPressed: () => widget.onSelected(state.stations[index]),
                    onFavorite: () {
                      SavedStation savedStation = SavedStation(
                        state.stations[index],
                        isFavourite: isFavourite,
                      );

                      context.read<StationsBloc>().add(
                            UpdateFavorite(savedStation: savedStation),
                          );
                    },
                    isFavourite: isFavourite,
                  );
                },
                physics: ClampingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1, height: 1),
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
