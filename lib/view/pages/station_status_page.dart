import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/station_status/stationstatus.dart';

import 'package:treninoo/model/Station.dart';
import 'package:treninoo/model/StationTrain.dart';
import 'package:treninoo/view/components/station_train_card.dart';
import 'package:treninoo/view/components/train_status/station_status_appbar.dart';
import 'package:treninoo/view/components/train_status/train_status_appbar.dart';

class StationStatusPage extends StatefulWidget {
  final Station station;

  StationStatusPage({Key key, this.station}) : super(key: key);

  @override
  _StationStatusPageState createState() => _StationStatusPageState();
}

class _StationStatusPageState extends State<StationStatusPage> {
  _StationStatusPageState() : super();

  List<StationTrain> departureTrains;
  List<StationTrain> arrivalTrains;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Theme.of(context).buttonColor,
        onRefresh: () async {
          context.read<StationStatusBloc>().add(
              StationStatusRequest(stationCode: widget.station.stationCode));
          return context
              .read<StationStatusBloc>()
              .stream
              .firstWhere((e) => e is! StationStatusLoading);
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
                    BlocListener<StationStatusBloc, StationStatusState>(
                      listener: (context, state) {
                        if (state is StationStatusSuccess) {
                          setState(() {
                            departureTrains = state.departureTrains;
                            arrivalTrains = state.arrivalTrains;
                          });
                        }
                      },
                      child: StationAppBar(
                        stationName: widget.station.stationName,
                      ),
                    ),
                    SizedBox(height: 8),
                    BlocBuilder<StationStatusBloc, StationStatusState>(
                      builder: (context, state) {
                        print(state);
                        if (state is StationStatusInitial) {
                          context
                              .read<StationStatusBloc>()
                              .add(StationStatusRequest(
                                stationCode: widget.station.stationCode,
                              ));
                        }
                        if (state is StationStatusSuccess) {
                          print(state.arrivalTrains.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.arrivalTrains.length,
                            itemBuilder: (context, index) {
                              return StationTrainCard(
                                  stationTrain: state.arrivalTrains[index]);
                              // return TrainCard(
                              //   savedTrain: trains[index],
                              //   savedTrainType: savedTrainType,
                              // );
                            },
                          );
                        }
                        // if (state is StationStatusLoading &&
                        //     departureTrains != null) {
                        //   return Column(
                        //     children: [
                        //       TrainInfoDetails(
                        //         trainInfo: departureTrains,
                        //       ),
                        //       SizedBox(height: 24),
                        //       TrainInfoStopsHeader(),
                        //       SizedBox(height: 8),
                        //       StationStatusStopList(
                        //         stops: departureTrains.stops,
                        //         currentStop:
                        //             departureTrains.lastPositionRegister,
                        //       )
                        //     ],
                        //   );
                        // }
                        if (state is StationStatusLoading)
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                        // if (state is StationStatusFailed)
                        //   return StationStatusNotFound(
                        //     savedTrain: widget.station,
                        //   );
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
