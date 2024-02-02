import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/view/components/favourites/no_favourites.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/train_exist/train_handler.dart';
import 'package:treninoo/view/router/routes_names.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../enum/saved_train_type.dart';
import '../components/train_card.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  bool get haveFavourites =>
      context.watch<FavouritesBloc>().state is FavouritesSuccess &&
      (context.watch<FavouritesBloc>().state as FavouritesSuccess)
          .trains
          .isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return HandleExistBloc(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Header(
                    title: "I tuoi treni",
                    description:
                        "Qui puoi trovare i treni che hai scelto come preferiti",
                    icon: haveFavourites ? Boxicons.bx_edit_alt : null,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RoutesNames.reorderFavourites,
                      );
                    },
                  ),
                  SizedBox(height: kPadding),
                  BlocBuilder<FavouritesBloc, FavouritesState>(
                    builder: (context, state) {
                      if (state is FavouritesSuccess) {
                        if (state.trains.isEmpty)
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: NoFavourites(),
                            ),
                          );

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.trains.length,
                          itemBuilder: (context, index) {
                            return TrainCard(
                              savedTrain: state.trains[index],
                              type: SavedTrainType.favourites,
                            );
                          },
                        );
                      }

                      if (state is FavouritesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
