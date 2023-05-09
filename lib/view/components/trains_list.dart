import 'package:flutter/material.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/train_card.dart';

class SavedTrainList extends StatelessWidget {
  const SavedTrainList({Key key, this.trains, this.savedTrainType})
      : super(key: key);

  final List<SavedTrain> trains;
  final SavedTrainType savedTrainType;

  get emptyText {
    switch (savedTrainType) {
      case SavedTrainType.recents:
        return "Nessun recente";
      case SavedTrainType.favourites:
        return "Nessun preferito";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (trains.length == 0)
      return Text(
        emptyText,
        textAlign: TextAlign.center,
      );

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trains.length,
      itemBuilder: (context, index) {
        return TrainCard(
          savedTrain: trains[index],
          type: savedTrainType,
        );
      },
    );
  }
}
