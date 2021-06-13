import 'package:flutter/material.dart';

enum ButtonType { filled, outlined }

class ActionButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton(
      {Key key,
      this.title,
      this.width = double.infinity,
      this.height = 54,
      this.color,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                color ?? Theme.of(context).primaryColor),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ));
  }
}

class BeautifulBackButton extends StatelessWidget {
  const BeautifulBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Center(
            child: Icon(
          Icons.arrow_back_ios_rounded,
          color: Theme.of(context).primaryColor,
        )),
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onSurface: Colors.green,
        ),
      ),
    );
  }
}

// class DialogButton extends StatelessWidget {
//   final String title;
//   final double height;
//   final Color color;
//   final Color textColor;
//   final Color borderColor;
//   final VoidCallback onPressed;
//   final ButtonType type;

//   const DialogButton({
//     Key key,
//     this.title,
//     this.height = 38,
//     this.color,
//     this.textColor = Colors.white,
//     this.borderColor,
//     this.onPressed,
//     this.type = ButtonType.filled,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (type == ButtonType.outlined)
//       return Expanded(
//         child: Container(
//             height: height,
//             child: OutlinedButton(
//               onPressed: onPressed,
//               child: Text(
//                 title,
//                 style: TextStyle(color: textColor),
//               ),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                     Theme.of(context).scaffoldBackgroundColor),
//                 elevation: MaterialStateProperty.all<double>(0),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             )),
//       );

//     return Expanded(
//       child: Container(
//           height: height,
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: onPressed,
//             child: Text(
//               title,
//               style: TextStyle(color: textColor),
//             ),
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(
//                   color ?? Theme.of(context).primaryColor),
//               elevation: MaterialStateProperty.all<double>(0),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
