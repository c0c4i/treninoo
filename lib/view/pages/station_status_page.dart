import 'dart:async';

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

class _StationStatusPageState extends State<StationStatusPage>
    with SingleTickerProviderStateMixin {
  _StationStatusPageState() : super();

  List<StationTrain> departureTrains;
  List<StationTrain> arrivalTrains;

  TabController _tabController;

  Timer timer;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => context.read<StationStatusBloc>().add(StationStatusRequest(
              stationCode: widget.station.stationCode,
            )));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: BlocListener<StationStatusBloc, StationStatusState>(
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
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  // indicatorPadding: EdgeInsets.all(16),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Partenze'),
                    Tab(text: 'Arrivi'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              BlocConsumer<StationStatusBloc, StationStatusState>(
                listener: (context, state) {
                  if (state is StationStatusSuccess) {
                    setState(() {
                      departureTrains = state.departureTrains;
                      arrivalTrains = state.arrivalTrains;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is StationStatusInitial) {
                    context.read<StationStatusBloc>().add(StationStatusRequest(
                          stationCode: widget.station.stationCode,
                        ));
                  }
                  if (state is StationStatusSuccess) {
                    return Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          departureTrains.length > 0
                              ? ListView.builder(
                                  itemCount: departureTrains.length,
                                  itemBuilder: (context, index) {
                                    return StationTrainCard(
                                        stationTrain: departureTrains[index]);
                                  },
                                )
                              : Center(child: Text("Nessun treno in partenza")),
                          arrivalTrains.length > 0
                              ? ListView.builder(
                                  itemCount: arrivalTrains.length,
                                  itemBuilder: (context, index) {
                                    return StationTrainCard(
                                        stationTrain: arrivalTrains[index]);
                                  },
                                )
                              : Center(child: Text("Nessun treno in arrivo")),
                        ],
                      ),
                    );
                  }
                  if (state is StationStatusLoading &&
                      departureTrains != null &&
                      arrivalTrains != null) {
                    return Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          departureTrains.length > 0
                              ? ListView.builder(
                                  itemCount: departureTrains.length,
                                  itemBuilder: (context, index) {
                                    return StationTrainCard(
                                        stationTrain: departureTrains[index]);
                                  },
                                )
                              : Center(child: Text("Nessun treno in partenza")),
                          arrivalTrains.length > 0
                              ? ListView.builder(
                                  itemCount: arrivalTrains.length,
                                  itemBuilder: (context, index) {
                                    return StationTrainCard(
                                        stationTrain: arrivalTrains[index]);
                                  },
                                )
                              : Center(child: Text("Nessun treno in arrivo")),
                        ],
                      ),
                    );
                  }
                  if (state is StationStatusLoading)
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
    );
  }
}
