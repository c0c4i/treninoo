import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/stations_autocomplete/stations_autocomplete.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/repository/train.dart';
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
      builder: (_) => BlocProvider(
        create: (context) => StationsAutocompleteBloc(
          context.read<TrainRepository>(),
        ),
        child: StationPickerContent(),
      ),
    );
  }
}

class StationPickerContent extends StatefulWidget {
  const StationPickerContent({super.key});

  @override
  State<StationPickerContent> createState() => _StationPickerContentState();
}

class _StationPickerContentState extends State<StationPickerContent> {
  final FocusNode searchFocus = FocusNode();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: Uncomment when ready to use
    // searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                controller: searchController,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  context.read<StationsAutocompleteBloc>().add(
                        GetStationsAutocomplete(text: text),
                      );
                },
              ),
              SizedBox(height: kPadding),
              Expanded(
                child: BlocBuilder<StationsAutocompleteBloc,
                    StationsAutocompleteState>(
                  builder: (context, state) {
                    if (state is StationsAutocompleteSuccess) {
                      return StationsList(
                        stations: state.stations,
                        onSelected: (station) {
                          Navigator.pop(context, station);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              if (searchController.text.isEmpty) SavedStationsList(),
            ],
          ),
        ),
      ),
    );
  }
}
