import 'package:flutter/material.dart';
import 'package:treninoo/view/components/prefixicon.dart';

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
        IconButton(icon: Icon(Icons.clear), onPressed: onClear)
      ],
    );
  }
}


// class CustomTextFieldClean extends StatelessWidget {
//   final String labelText;
//   final TextCapitalization textCapitalization;
//   final TextInputType keyboardType;
//   final TextEditingController controller;
//   final String Function(String) validator;

//   const CustomTextFieldClean({
//     Key key,
//     this.labelText,
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
//         contentPadding: EdgeInsets.all(14), // was set to 10
//       ),
//       controller: controller,
//       keyboardType: keyboardType,
//       autocorrect: false,
//       validator: validator,
//     );
//   }
// }
