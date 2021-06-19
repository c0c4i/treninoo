import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/train_card.dart';

class SavedTrainList extends StatelessWidget {
  const SavedTrainList({Key key, this.trains}) : super(key: key);

  final List<SavedTrain> trains;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trains.length,
      itemBuilder: (context, index) {
        return TrainCard(
          train: trains[index],
        );
      },
    );
  }
}
