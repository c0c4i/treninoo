import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class TrainStatusNotFound extends StatelessWidget {
  final SavedTrain? savedTrain;

  const TrainStatusNotFound({Key? key, this.savedTrain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/train_not_found.png'),
            height: 140,
          ),
          SizedBox(height: 32),
          Text(
            "Treno non trovato",
            style: Typo.headlineHeavy,
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 200,
            child: Text(
              "Lo stato di questo treno non è ancora disponibile",
              style: Typo.subheaderLight.copyWith(color: Grey.dark),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32),
          ActionButton(
            title: "Riprova",
            width: 160,
            onPressed: () {
              context
                  .read<TrainStatusBloc>()
                  .add(TrainStatusRequest(savedTrain: savedTrain));
            },
          )
        ],
      ),
    );
  }
}
