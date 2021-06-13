import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/prefixicon.dart';
import 'package:treninoo/view/components/suggestion_row.dart';

class BeautifulTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String Function(String) validator;
  final bool enabled;

  const BeautifulTextField({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.emailAddress,
    this.controller,
    this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: PrefixIcon(icon: prefixIcon),
        contentPadding: EdgeInsets.all(18),
      ),
      style: TextStyle(fontSize: 18),
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: false,
      validator: validator,
      enabled: enabled,
    );
  }
}

// class SuggestionTextField extends StatelessWidget {
//   final String labelText;
//   final IconData prefixIcon;
//   final TextCapitalization textCapitalization;
//   final TextInputType keyboardType;
//   final TextEditingController controller;
//   final String Function(String) validator;

//   const SuggestionTextField({
//     Key key,
//     this.labelText,
//     this.prefixIcon,
//     this.textCapitalization = TextCapitalization.sentences,
//     this.keyboardType = TextInputType.emailAddress,
//     this.controller,
//     this.validator,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       textCapitalization: textCapitalization,
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: PrefixIcon(icon: prefixIcon),
//         contentPadding: EdgeInsets.all(18),
//       ),
//       style: TextStyle(fontSize: 18),
//       controller: controller,
//       keyboardType: keyboardType,
//       autocorrect: false,
//       validator: validator,
//     );
//   }
// }

class ClickableTextField extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final VoidCallback onClear;
  final String Function(String) validator;

  const ClickableTextField({
    Key key,
    this.onPressed,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.onClear,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onPressed,
    //   child: CustomTextFieldWithPrefixIcon(
    //     labelText: labelText,
    //     prefixIcon: prefixIcon,
    //     controller: controller,
    //     enabled: false,
    //   ),
    // );

    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onPressed,
            child: BeautifulTextField(
              labelText: labelText,
              prefixIcon: prefixIcon,
              controller: controller,
              validator: validator,
              enabled: false,
            ),
          ),
        ),
        // IconButton(icon: Icon(Icons.clear), onPressed: onClear)
      ],
    );
  }
}

class SuggestionTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(Station) onSelect;

  const SuggestionTextField(
      {Key key, this.label, this.controller, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> map = Map<String, String>();

    Future<List<String>> suggestionCreator(String text) async {
      List<String> names = [];
      List<Station> stations = [];
      if (text.length > 0) {
        stations = await getStationListStartWith(text);
      } else {
        stations = await fetchRecentsStations(spRecentsStations);
      }

      if (stations == null) return null;
      stations.forEach((station) {
        map[station.stationName] = station.stationCode;
        names.add(station.stationName);
      });
      return names;
    }

    return TypeAheadField(
        getImmediateSuggestions: true,
        hideOnEmpty: true,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          elevation: 16,
        ),
        textFieldConfiguration: TextFieldConfiguration(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          controller: controller,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: PrefixIcon(icon: Icons.gps_fixed_rounded),
            labelText: label,
          ),
        ),
        suggestionsCallback: (text) async {
          return suggestionCreator(text);
        },
        itemBuilder: (context, suggestion) {
          return SuggestionRow(suggestion: suggestion);
        },
        onSuggestionSelected: (clicked) {
          Station station = new Station(
            stationCode: map[clicked],
            stationName: clicked,
          );
          onSelect(station);
          controller.text = clicked;
        });
  }
}
