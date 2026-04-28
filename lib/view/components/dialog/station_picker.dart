import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations/stations.dart';
import 'package:treninoo/bloc/stations_autocomplete/stations_autocomplete.dart';
import 'package:treninoo/cubit/nearby_stations.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/stations/nearby_stations_list.dart';
import 'package:treninoo/view/components/stations/saved_stations_list.dart';
import 'package:treninoo/view/components/stations/stations_list.dart';
import 'package:treninoo/view/components/textfield.dart';
import 'package:treninoo/view/style/colors/black.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class StationPickerDialog {
  static Future<Station?> show({
    required BuildContext context,
    required SearchStationType type,
  }) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kRadius),
        ),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StationsAutocompleteBloc(
              context.read<TrainRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => NearbyStationsCubit()..loadNearbyStations(),
          ),
        ],
        child: StationPickerContent(type: type),
      ),
    );
  }
}

class StationPickerContent extends StatefulWidget {
  const StationPickerContent({super.key, required this.type});

  final SearchStationType type;

  @override
  State<StationPickerContent> createState() => _StationPickerContentState();
}

class _StationPickerContentState extends State<StationPickerContent> {
  final FocusNode searchFocus = FocusNode();
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchFocus.requestFocus();
    context.read<StationsBloc>().add(GetStations());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void selectStation(Station station) {
    Navigator.pop(context, station);
  }

  void _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<StationsAutocompleteBloc>().add(
            GetStationsAutocomplete(
              text: text,
              type: widget.type,
            ),
          );
    });
  }

  bool get isLoading {
    final state = context.watch<StationsAutocompleteBloc>().state;
    return state is StationsAutocompleteLoading;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kPadding * 1.2, horizontal: kPadding * 1.2),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.86,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seleziona stazione",
                      style: Typo.titleHeavy,
                    ),
                    CircleAvatar(
                      backgroundColor: Grey.lighter,
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.close_rounded,
                          size: 22,
                          color: Black.normal,
                        ),
                        constraints: BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: Grey.darker,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8, width: double.infinity),
                BeautifulTextField(
                  labelText: "Ricerca",
                  focusNode: searchFocus,
                  textCapitalization: TextCapitalization.words,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: _onSearchChanged,
                  loading: isLoading,
                ),
                SizedBox(height: kPadding),
                if (searchController.text.isNotEmpty)
                  StationsList(onSelected: selectStation),
                if (searchController.text.isEmpty) ...[
                  NearbyStationsList(onSelected: selectStation),
                  SavedStationsList(onSelected: selectStation),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
