import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/departure_station/departurestation.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/dialog/departure_stations_dialog.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/loading_dialog.dart';
import 'package:treninoo/view/components/textfield.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/view/style/theme.dart';

import '../../bloc/exist/exist.dart';
import '../../model/DepartureStation.dart';
import '../components/recents_trains/recents_list.dart';
import '../components/train_exist/train_handler.dart';

enum ErrorType {
  zero,
  empty,
  not_found,
}

class SearchTrainPage extends StatefulWidget {
  SearchTrainPage({Key key}) : super(key: key);

  @override
  _SearchTrainPageState createState() => _SearchTrainPageState();
}

class _SearchTrainPageState extends State<SearchTrainPage> {
  String error;

  TextEditingController searchController = TextEditingController();

  Future<List<SavedTrain>> recents;

  void showError(ErrorType errorType) {
    setState(() {
      error = getError(errorType);
    });
  }

  String getError(ErrorType errorType) {
    String trainCode = searchController.text;
    if (trainCode.length > 0 && errorType == ErrorType.zero) {
      return null;
    }

    switch (errorType) {
      case ErrorType.empty:
        return 'E\' necessario inserire il codice';
      case ErrorType.not_found:
        return 'Codice Treno non valido';
      default:
        return null;
    }
  }

  /* funzioni svolte quando viene premuto il tasto cerca:
        - Zero treni: mostra errore 1
        - Un treno: apre il treno con le informazioni
        - Due treni: 
  */
  void searchButtonClick() {
    FocusScope.of(context).unfocus();
    if (searchController.text.length == 0) {
      showError(ErrorType.empty);
      return;
    }
    String trainCode = searchController.text;
    context
        .read<DepartureStationBloc>()
        .add(DepartureStationRequest(trainCode: trainCode));
  }

  final _formKey = GlobalKey<FormState>();

  handleDepartureStations(List<DepartureStation> departureStations) async {
    int trainFound = departureStations.length;

    if (trainFound == 0) return showError(ErrorType.not_found);

    SavedTrain savedTrain;
    switch (trainFound) {
      case 1:
        savedTrain = SavedTrain.fromDepartureStation(departureStations[0]);
        break;
      default:
        DepartureStation departureStation = await DepartureStationsDialog.show(
          context,
          departureStations: departureStations,
        );
        if (departureStation == null) return;
        savedTrain = SavedTrain.fromDepartureStation(departureStation);
    }

    context.read<ExistBloc>().add(
          ExistRequest(savedTrain: savedTrain),
        );
  }

  @override
  Widget build(BuildContext context) {
    return HandleExistBloc(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: BlocListener<DepartureStationBloc, DepartureStationState>(
                listener: (context, state) {
                  if (state is DepartureStationLoading)
                    LoadingDialog.show(context);

                  if (state is DepartureStationSuccess) {
                    LoadingDialog.hide(context);
                    handleDepartureStations(state.departureStations);
                  }
                  if (state is DepartureStationFailed)
                    LoadingDialog.hide(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Header(
                        title: "Cerca il tuo treno",
                        description:
                            "Se conosci il numero del tuo treno inseriscilo qui per conoscere il suo stato",
                      ),
                      SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: BeautifulTextField(
                          prefixIcon: Icons.search,
                          labelText: "Codice treno",
                          controller: searchController,
                          keyboardType: TextInputType.number,
                          errorText: error,
                        ),
                      ),
                      SizedBox(height: 20),
                      ActionButton(
                        title: "Cerca",
                        onPressed: searchButtonClick,
                      ),
                      SizedBox(height: 50),
                      RecentsTrains(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
