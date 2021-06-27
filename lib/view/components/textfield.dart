import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
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
  final String errorText;
  final bool enabled;

  const BeautifulTextField({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.emailAddress,
    this.controller,
    this.validator,
    this.errorText,
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
          errorText: errorText),
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

class SuggestionTextField extends StatefulWidget {
  final String label;
  final String errorText;
  final TextEditingController controller;
  final Function(Station) onSelect;
  final Function(String) validator;

  SuggestionTextField(
      {Key key,
      this.label,
      this.controller,
      this.onSelect,
      this.validator,
      this.errorText})
      : super(key: key);

  @override
  _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  Map<String, String> map = Map<String, String>();

  Future<List<String>> suggestionCreator(String text) async {
    List<String> names = [];
    List<Station> stations = [];
    if (text.length > 0) {
      stations = await getStationListStartWith(text);
    } else {
      stations = fetchRecentsStations();
    }

    if (stations == null) return null;
    stations.forEach((station) {
      // setState(() {
      map[station.stationName] = station.stationCode;
      // });
      names.add(station.stationName);
    });

    return names;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      getImmediateSuggestions: true,
      hideOnEmpty: true,
      loadingBuilder: (context) {
        return Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.center,
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      },
      noItemsFoundBuilder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Text(
            "Stazione non trovata",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        elevation: 16,
      ),
      textFieldConfiguration: TextFieldConfiguration(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          controller: widget.controller,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: PrefixIcon(icon: Icons.gps_fixed_rounded),
            labelText: widget.label,
            errorText: widget.errorText,
          ),
          onChanged: (station) {
            widget.onSelect(null);
          }),
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
        widget.onSelect(station);
        widget.controller.text = clicked;
      },
    );
  }
}
