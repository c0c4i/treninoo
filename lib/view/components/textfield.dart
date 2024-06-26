import 'package:flutter/material.dart';
import 'package:treninoo/view/components/prefixicon.dart';

class BeautifulTextField extends StatelessWidget {
  final String? labelText;
  final IconData? prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  final String? errorText;
  final bool enabled;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const BeautifulTextField({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.emailAddress,
    this.controller,
    this.validator,
    this.errorText,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? PrefixIcon(icon: prefixIcon) : null,
        contentPadding: EdgeInsets.all(16),
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: false,
      validator: validator,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
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
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? labelText;
  final VoidCallback? onClear;
  final String Function(String?)? validator;

  const ClickableTextField({
    Key? key,
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

// class SuggestionTextField extends StatefulWidget {
//   final String? label;
//   final String? errorText;
//   final TextEditingController? controller;
//   final Function(Station?) onSelect;
//   final Function(String)? validator;
//   final SearchStationType type;

//   SuggestionTextField({
//     Key? key,
//     this.label,
//     this.controller,
//     required this.onSelect,
//     this.validator,
//     this.errorText,
//     required this.type,
//   }) : super(key: key);

//   @override
//   _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
// }

// class _SuggestionTextFieldState extends State<SuggestionTextField> {
//   Future<List<Station?>> suggestionsCallback(String pattern) async {
//     return pattern.length == 0
//         ? context.read<SavedTrainRepository>().getRecentsAndFavouritesStations()
//         : await context
//             .read<TrainRepository>()
//             .searchStations(pattern, widget.type);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<Station?>(
//       getImmediateSuggestions: true,
//       hideOnEmpty: true,
//       loadingBuilder: (context) {
//         return Container(
//           width: double.infinity,
//           height: 64,
//           alignment: Alignment.center,
//           child: SizedBox(
//             height: 32,
//             width: 32,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//       noItemsFoundBuilder: (context) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//           child: Text(
//             "Stazione non trovata",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         );
//       },
//       suggestionsBoxDecoration: SuggestionsBoxDecoration(
//         borderRadius: BorderRadius.circular(kRadius),
//         elevation: 16,
//       ),
//       textFieldConfiguration: TextFieldConfiguration(
//         keyboardType: TextInputType.text,
//         textCapitalization: TextCapitalization.words,
//         controller: widget.controller,
//         style: TextStyle(fontSize: 18),
//         decoration: InputDecoration(
//           prefixIcon: PrefixIcon(icon: Icons.gps_fixed_rounded),
//           labelText: widget.label,
//           errorText: widget.errorText,
//           errorStyle: TextStyle(height: 0),
//         ),
//         // onChanged: (station) {
//         //   widget.onSelect(null);
//         // },
//       ),
//       suggestionsCallback: suggestionsCallback,
//       itemBuilder: (context, station) {
//         return StationSuggestion(station: station!);
//       },
//       onSuggestionSelected: widget.onSelect,
//     );
//   }
// }
