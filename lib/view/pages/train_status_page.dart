import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:treninoo/bloc/train_status/trainstatus.dart';
import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/utils/accessibility/changes_announcer.dart';
import 'package:treninoo/view/components/train_status/train_status_appbar.dart';
import 'package:treninoo/view/components/train_status/train_status_details.dart';
import 'package:treninoo/view/components/train_status/train_status_not_found.dart';
import 'package:treninoo/view/components/train_status/train_status_stop_list.dart';
import 'package:treninoo/view/components/train_status/train_status_stops_header.dart';
import 'package:treninoo/view/style/theme.dart';

class TrainStatusPage extends StatefulWidget {
  final SavedTrain savedTrain;

  TrainStatusPage({Key? key, required this.savedTrain}) : super(key: key);

  @override
  _TrainStatusPageState createState() => _TrainStatusPageState();
}

class _TrainStatusPageState extends State<TrainStatusPage> {
  _TrainStatusPageState() : super();

  TrainInfo? trainInfo;

  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => context.read<TrainStatusBloc>().add(
              TrainStatusRequest(savedTrain: widget.savedTrain),
            ));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<TrainStatusBloc, TrainStatusState>(
          listener: (context, state) {
            if (state is TrainStatusSuccess) {
              setState(() {
                if (trainInfo == null) {
                  trainInfo = state.trainInfo;
                  return;
                }

                AccessibilityChangesAnnouncer.announceChanges(
                  context,
                  trainInfo!,
                  state.trainInfo,
                );

                trainInfo = state.trainInfo;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: <Widget>[
                TrainAppBar(savedTrain: widget.savedTrain),
                SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<TrainStatusBloc, TrainStatusState>(
                    builder: (context, state) {
                      if (state is TrainStatusInitial) {
                        context.read<TrainStatusBloc>().add(
                            TrainStatusRequest(savedTrain: widget.savedTrain));
                      }
                      if ((state is TrainStatusSuccess ||
                              state is TrainStatusLoading) &&
                          trainInfo != null)
                        return Column(
                          children: [
                            TrainInfoDetails(
                              trainInfo: trainInfo!,
                            ),
                            SizedBox(height: 24),
                            Semantics(
                              excludeSemantics: true,
                              child: TrainInfoStopsHeader(),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  context.read<TrainStatusBloc>().add(
                                        TrainStatusRequest(
                                            savedTrain: widget.savedTrain),
                                      );
                                  return context
                                      .read<TrainStatusBloc>()
                                      .stream
                                      .firstWhere(
                                          (e) => e is! TrainStatusLoading)
                                      .then((value) => null);
                                },
                                child: TrainStatusStopList(
                                  stops: trainInfo?.stops,
                                  currentStop: trainInfo?.lastPositionRegister,
                                  delay: trainInfo!.delay!,
                                ),
                              ),
                            ),
                            // PredictedArrivalAlert(
                            //   onActivate: () {
                            //     context
                            //         .read<PredictedArrivalCubit>()
                            //         .setValue(true);
                            //     setState(
                            //       () {},
                            //     );
                            //   },
                            // ),
                          ],
                        );

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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
