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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          child: SafeArea(
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
                BlocBuilder<StationStatusBloc, StationStatusState>(
                  builder: (context, state) {
                    if (state is StationStatusInitial) {
                      context
                          .read<StationStatusBloc>()
                          .add(StationStatusRequest(
                            stationCode: widget.station.stationCode,
                          ));
                    }
                    if (state is StationStatusSuccess) {
                      return Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ListView.builder(
                              itemCount: state.departureTrains.length,
                              itemBuilder: (context, index) {
                                return StationTrainCard(
                                    stationTrain: state.departureTrains[index]);
                              },
                            ),
                            ListView.builder(
                              itemCount: state.arrivalTrains.length,
                              itemBuilder: (context, index) {
                                return StationTrainCard(
                                    stationTrain: state.arrivalTrains[index]);
                              },
                            ),
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
      ),
    );
  }
}
