import 'package:flutter/material.dart';
import 'package:treninoo/view/components/prefixicon.dart';

class BeautifulTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String Function(String) validator;

  const BeautifulTextField({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.emailAddress,
    this.controller,
    this.validator,
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
