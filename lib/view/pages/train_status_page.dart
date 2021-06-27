import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/model/DepartureStation.dart';
import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/utils/shared_preference_methods.dart';
import 'package:treninoo/view/components/train_status/train_status_appbar.dart';
import 'package:treninoo/view/components/train_status/train_status_details.dart';
import 'package:treninoo/view/components/train_status/train_status_not_found.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_list.dart';
import 'package:treninoo/view/components/train_status/train_status_stops_header.dart';

class TrainStatusPage extends StatefulWidget {
  final SavedTrain savedTrain;

  TrainStatusPage({Key key, this.savedTrain}) : super(key: key);

  @override
  _TrainStatusPageState createState() => _TrainStatusPageState();
}

class _TrainStatusPageState extends State<TrainStatusPage> {
  _TrainStatusPageState() : super();

  TrainInfo trainInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Theme.of(context).buttonColor,
        onRefresh: () async {
          context.read<TrainStatusBloc>().add(
                TrainStatusRequest(savedTrain: widget.savedTrain),
              );
          return context
              .read<TrainStatusBloc>()
              .stream
              .firstWhere((e) => e is! TrainStatusLoading);
        },
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              minimum: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    BlocConsumer<TrainStatusBloc, TrainStatusState>(
                      listener: (context, state) {
                        if (state is TrainStatusSuccess) {
                          SavedTrain savedTrain =
                              SavedTrain.fromTrainInfo(state.trainInfo);
                          addTrain(savedTrain, SavedTrainType.recents);
                          setState(() {
                            trainInfo = state.trainInfo;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is TrainStatusSuccess) {
                          String trainType = state.trainInfo.trainType;
                          String trainCode = state.trainInfo.trainCode;
                          return TrainAppBar(
                            number: "$trainType $trainCode",
                            trainInfo: state.trainInfo,
                          );
                        }
                        if (state is TrainStatusLoading && trainInfo != null) {
                          String trainType = trainInfo.trainType;
                          String trainCode = trainInfo.trainCode;
                          return TrainAppBar(
                            number: "$trainType $trainCode",
                            trainInfo: trainInfo,
                          );
                        }
                        return TrainAppBar(
                          number: widget.savedTrain.trainCode,
                          trainInfo: null,
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    BlocBuilder<TrainStatusBloc, TrainStatusState>(
                      builder: (context, state) {
                        if (state is TrainStatusInitial) {
                          context.read<TrainStatusBloc>().add(
                              TrainStatusRequest(
                                  savedTrain: widget.savedTrain));
                        }
                        if (state is TrainStatusSuccess)
                          return Column(
                            children: [
                              TrainInfoDetails(
                                trainInfo: state.trainInfo,
                              ),
                              SizedBox(height: 24),
                              TrainInfoStopsHeader(),
                              SizedBox(height: 8),
                              TrainStatusStopList(
                                stops: state.trainInfo.stops,
                                currentStop:
                                    state.trainInfo.lastPositionRegister,
                              )
                            ],
                          );
                        if (state is TrainStatusLoading && trainInfo != null) {
                          return Column(
                            children: [
                              TrainInfoDetails(
                                trainInfo: trainInfo,
                              ),
                              SizedBox(height: 24),
                              TrainInfoStopsHeader(),
                              SizedBox(height: 8),
                              TrainStatusStopList(
                                stops: trainInfo.stops,
                                currentStop: trainInfo.lastPositionRegister,
                              )
                            ],
                          );
                        }
                        if (state is TrainStatusLoading)
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                        if (state is TrainStatusFailed)
                          return TrainStatusNotFound(
                            savedTrain: widget.savedTrain,
                          );
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
