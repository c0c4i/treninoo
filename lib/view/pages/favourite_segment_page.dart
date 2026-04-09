import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:treninoo/bloc/favourite/favourite.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/utils/core.dart';
import 'package:treninoo/view/components/buttons/back_button.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class FavouriteSegmentPage extends StatefulWidget {
  final SavedTrain savedTrain;
  final List<Stop> stops;

  const FavouriteSegmentPage({
    Key? key,
    required this.savedTrain,
    required this.stops,
  }) : super(key: key);

  @override
  State<FavouriteSegmentPage> createState() => _FavouriteSegmentPageState();
}

class _FavouriteSegmentPageState extends State<FavouriteSegmentPage> {
  int? _departureIndex;
  int? _arrivalIndex;

  bool get _isFullySelected => _departureIndex != null && _arrivalIndex != null;

  bool _isInSegment(int index) {
    if (_departureIndex == null) return false;
    if (_arrivalIndex == null) return index == _departureIndex;
    return index >= _departureIndex! && index <= _arrivalIndex!;
  }

  bool _isConnectorInSegment(int index) {
    if (_departureIndex == null || _arrivalIndex == null) return false;
    return index >= _departureIndex! && index < _arrivalIndex!;
  }

  void _onTap(int index) {
    setState(() {
      if (_departureIndex == null) {
        _departureIndex = index;
      } else if (_arrivalIndex == null) {
        if (index == _departureIndex) {
          _departureIndex = null;
        } else if (index > _departureIndex!) {
          _arrivalIndex = index;
        } else {
          // Tapped above departure: shift departure down
          _arrivalIndex = _departureIndex;
          _departureIndex = index;
        }
      } else {
        // Reset and start a new selection
        _departureIndex = index;
        _arrivalIndex = null;
      }
    });
  }

  void _onConfirm() {
    if (!_isFullySelected) return;

    final departureStop = widget.stops[_departureIndex!];
    final arrivalStop = widget.stops[_arrivalIndex!];

    String? depTime;
    if (departureStop.plannedDepartureTime != null) {
      depTime = formatTimeOfDay(departureStop.plannedDepartureTime!);
    } else if (departureStop.plannedArrivalTime != null) {
      depTime = formatTimeOfDay(departureStop.plannedArrivalTime!);
    }

    String? arrTime;
    if (arrivalStop.plannedArrivalTime != null) {
      arrTime = formatTimeOfDay(arrivalStop.plannedArrivalTime!);
    } else if (arrivalStop.plannedDepartureTime != null) {
      arrTime = formatTimeOfDay(arrivalStop.plannedDepartureTime!);
    }

    final updatedSavedTrain = widget.savedTrain.copyWith(
      selectedSegmentDepartureStationName: departureStop.station.stationName,
      selectedSegmentArrivalStationName: arrivalStop.station.stationName,
      selectedSegmentDepartureTime: depTime,
      selectedSegmentArrivalTime: arrTime,
    );

    context.read<FavouriteBloc>().add(
          FavouriteToggle(savedTrain: updatedSavedTrain, value: true),
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BeautifulBackButton(),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      widget.savedTrain.trainName ??
                          widget.savedTrain.trainCode,
                      style: TextStyle(
                        fontSize: 26,
                        color: Primary.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  "Seleziona il tratto del tuo treno preferito",
                  style: Typo.subheaderLight,
                ),
              ),
              const SizedBox(height: kPadding),
              Expanded(
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    nodeItemOverlap: true,
                    connectorTheme: ConnectorThemeData(
                      thickness: 14,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    indicatorBuilder: (context, index) {
                      final inSegment = _isInSegment(index);
                      return GestureDetector(
                        onTap: () => _onTap(index),
                        child: DotIndicator(
                          size: 14,
                          color: inSegment ? Colors.white : Grey.darker,
                          border: Border.all(
                            color: inSegment ? Primary.normal : Grey.normal,
                            width: 2.5,
                          ),
                        ),
                      );
                    },
                    connectorBuilder: (context, index, connectorType) {
                      final inSegment = _isConnectorInSegment(index);
                      return SolidLineConnector(
                        color: inSegment ? Primary.normal : Grey.normal,
                      );
                    },
                    contentsBuilder: (context, index) {
                      final stop = widget.stops[index];
                      final inSegment = _isInSegment(index);
                      final isDeparture = index == _departureIndex;
                      final isArrival = index == _arrivalIndex;

                      return InkWell(
                        onTap: () => _onTap(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPadding,
                            vertical: kPadding / 1.5,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  stop.station.stationName,
                                  style: Typo.subheaderLight.copyWith(
                                    color: inSegment
                                        ? Primary.normal
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                    fontWeight: (isDeparture || isArrival)
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (isDeparture) _SegmentBadge(label: "Partenza"),
                              if (isArrival) _SegmentBadge(label: "Arrivo"),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: widget.stops.length,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kPadding),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isFullySelected ? _onConfirm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Primary.normal,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Grey.normal,
                      padding: const EdgeInsets.symmetric(vertical: kPadding),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadius),
                      ),
                    ),
                    child: Text(
                      "Salva preferito",
                      style: Typo.subheaderHeavy.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SegmentBadge extends StatelessWidget {
  final String label;

  const _SegmentBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Primary.lightest2,
        borderRadius: BorderRadius.circular(kRadius / 2),
        border: Border.all(color: Primary.light),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Primary.normal,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
