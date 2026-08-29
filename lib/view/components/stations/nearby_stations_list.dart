import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/cubit/nearby_stations.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/saved_station.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';
import 'package:treninoo/view/router/routes_names.dart';

class NearbyStationsList extends StatelessWidget {
  final Function(Station) onSelected;

  /// If true, navigates to station page instead of calling onSelected callback.
  /// Useful for direct usage on pages (not in pickers/dialogs).
  final bool autoNavigate;

  const NearbyStationsList({
    Key? key,
    required this.onSelected,
    this.autoNavigate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyStationsCubit, NearbyStationsState>(
      builder: (context, state) {
        if (state is NearbyStationsLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.near_me_rounded, size: 16, color: Grey.dark),
                    SizedBox(width: 6),
                    Text(
                      "Stazioni vicine",
                      style: Typo.bodyHeavy.copyWith(color: Grey.dark),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is NearbyStationsSuccess && state.stations.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.near_me_rounded, size: 16, color: Grey.dark),
                  SizedBox(width: 6),
                  Text(
                    "Stazioni vicine",
                    style: Typo.bodyHeavy.copyWith(color: Grey.dark),
                  ),
                ],
              ),
              SizedBox(height: 8),
              BeautifulCard(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.stations.length,
                  separatorBuilder: (_, __) => Divider(thickness: 1, height: 1),
                  itemBuilder: (context, index) {
                    final nearby = state.stations[index];

                    return _NearbyStationCard(
                      station: nearby.station,
                      distanceKm: nearby.distanceKm,
                      onPressed: () {
                        context
                            .read<SavedStationsRepository>()
                            .addRecentOrFavoruiteStation(nearby.station);

                        if (autoNavigate) {
                          // Navigate to station status page and fetch data,
                          // following the same pattern as favourited/searched stations
                          Navigator.pushNamed(
                            context,
                            RoutesNames.station,
                            arguments: nearby.station,
                          );
                        } else {
                          // Use callback for picker dialog context
                          onSelected(nearby.station);
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: kPadding),
            ],
          );
        }

        // For initial / unavailable / failed states, show nothing
        return SizedBox.shrink();
      },
    );
  }
}

class _NearbyStationCard extends StatelessWidget {
  final Station station;
  final double distanceKm;
  final VoidCallback onPressed;

  const _NearbyStationCard({
    required this.station,
    required this.distanceKm,
    required this.onPressed,
  });

  String get _formattedDistance {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding * 1.2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      station.stationName,
                      style: Typo.subheaderHeavy.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              _formattedDistance,
              style: Typo.bodyLight.copyWith(color: Grey.dark),
            ),
          ],
        ),
      ),
    );
  }
}
