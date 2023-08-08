// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:treninoo/cubit/predicted_arrival.dart';
// import 'package:treninoo/view/style/colors/accent.dart';
// import 'package:treninoo/view/style/theme.dart';
// import 'package:treninoo/view/style/typography.dart';

// class PredictedArrivalAlert extends StatelessWidget {
//   final VoidCallback onActivate;

//   const PredictedArrivalAlert({
//     Key? key,
//     required this.onActivate,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: kPadding),
//       child: Container(
//         height: 48,
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(horizontal: kPadding),
//         decoration: BoxDecoration(
//           color: Accent.lightest2,
//           borderRadius: BorderRadius.circular(kRadius),
//         ),
//         child: !context.watch<PredictedArrivalCubit>().state
//             ? Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.auto_awesome_outlined,
//                     color: Accent.normal,
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       "Prova la nuova modalità predittiva",
//                       style: Typo.bodyLight.copyWith(
//                         color: Accent.normal,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: onActivate,
//                     style: TextButton.styleFrom(
//                       foregroundColor: Accent.normal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(kRadius / 2),
//                       ),
//                     ),
//                     child: Text(
//                       "Prova",
//                       style: Typo.bodyHeavy,
//                     ),
//                   ),
//                 ],
//               )
//             : SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   "Indica l’orario previsto in base al ritardo attuale",
//                   style: Typo.bodyLight.copyWith(
//                     color: Accent.normal,
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
