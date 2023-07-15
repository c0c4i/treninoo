import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/followtrain_stations/followtrainstations.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/theme.dart';

class FollowTrainPage extends StatefulWidget {
  final SavedTrain savedTrain;

  FollowTrainPage({Key? key, required this.savedTrain}) : super(key: key);

  @override
  _FollowTrainPageState createState() => _FollowTrainPageState();
}

class _FollowTrainPageState extends State<FollowTrainPage> {
  Station? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: <Widget>[
                BeautifulAppBar(
                  title: "Segui il treno",
                ),
                SizedBox(height: 16),
                BlocBuilder<FollowTrainStationsBloc, FollowTrainStationsState>(
                  builder: (context, state) {
                    if (state is FollowTrainStationsInitial)
                      context.read<FollowTrainStationsBloc>().add(
                            FollowTrainStationsRequest(
                                savedTrain: widget.savedTrain),
                          );
                    if (state is FollowTrainStationsSuccess)
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.stations.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                visualDensity: VisualDensity.comfortable,
                                title: Text(state.stations[index].stationName!),
                                groupValue: selected,
                                selected: selected == state.stations[index],
                                value: state.stations[index],
                                onChanged: (dynamic station) {
                                  setState(() {
                                    selected = station;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadius),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          ActionButton(
                            title: "Segui",
                            onPressed: () {},
                          ),
                        ],
                      );
                    if (state is FollowTrainStationsLoading)
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
