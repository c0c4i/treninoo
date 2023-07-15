import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../../enum/saved_train_type.dart';
import '../train_card.dart';

class RecentsTrains extends StatefulWidget {
  RecentsTrains({Key? key}) : super(key: key);

  @override
  _RecentsTrainsState createState() => _RecentsTrainsState();
}

class _RecentsTrainsState extends State<RecentsTrains> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentsBloc, RecentsState>(
      builder: (context, state) {
        if (state is RecentsSuccess && state.trains.length > 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Recenti", style: Typo.headlineLight),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.trains.length,
                itemBuilder: (context, index) {
                  return TrainCard(
                    savedTrain: state.trains[index],
                    type: SavedTrainType.recents,
                  );
                },
              ),
            ],
          );
        }

        return SizedBox();
      },
    );
  }
}
