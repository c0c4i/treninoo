import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';
import 'package:treninoo/view/style/colors/primary.dart';

import '../../../bloc/favourite/favourite.dart';
import '../../../bloc/favourites/favourites.dart';

class TrainAppBar extends StatefulWidget {
  final SavedTrain savedTrain;

  const TrainAppBar({Key? key, required this.savedTrain}) : super(key: key);

  @override
  _TrainAppBarState createState() => _TrainAppBarState();
}

class _TrainAppBarState extends State<TrainAppBar> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(
          FavouriteRequest(savedTrain: widget.savedTrain),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BeautifulBackButton(),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            widget.savedTrain.trainName!,
            style: TextStyle(
              fontSize: 26,
              color: Primary.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            // IconButton(
            //   iconSize: 40,
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       RoutesNames.followTrainStations,
            //       arguments: DepartureStation(
            //         station: Station(
            //           stationName: widget.trainInfo.departureStationName,
            //           stationCode: widget.trainInfo.departureStationCode,
            //         ),
            //         trainCode: widget.trainInfo.trainCode,
            //       ),
            //     );
            //   },
            //   icon: Icon(
            //     Icons.notifications_none_rounded,
            //     size: 35,
            //     color: Primary.normal,
            //   ),
            // ),
            BlocConsumer<FavouriteBloc, FavouriteState>(
              listener: (context, state) {
                if (state is FavouriteSuccess) {
                  context.read<FavouritesBloc>().add(FavouritesRequest());
                }
              },
              builder: (context, state) {
                if (state is FavouriteInitial || state is FavouriteLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (state is FavouriteSuccess) {
                  return Semantics(
                    label: state.isFavourite
                        ? "Rimuovi dai preferiti"
                        : "Aggiungi ai preferiti",
                    excludeSemantics: true,
                    button: true,
                    child: IconButton(
                      iconSize: 40,
                      onPressed: () {
                        context.read<FavouriteBloc>().add(
                              FavouriteToggle(
                                savedTrain: widget.savedTrain,
                                value: !state.isFavourite,
                              ),
                            );
                      },
                      icon: Icon(
                        state.isFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 35,
                        color: Primary.normal,
                      ),
                    ),
                  );
                }

                return SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
