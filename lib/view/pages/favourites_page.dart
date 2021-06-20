import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/header.dart';

import 'package:treninoo/view/components/train_card.dart';
import 'package:treninoo/view/components/trains_list.dart';

import 'package:treninoo/model/SavedTrain.dart';

import 'package:treninoo/utils/api.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/utils/final.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage({Key key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  _FavouritesPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Header(
                  title: "I tuoi treni",
                  description:
                      "Qui puoi trovare i treni che hai contrassegnato come preferiti",
                ),
                SizedBox(height: 20),
                BlocBuilder<FavouritesBloc, FavouritesState>(
                  builder: (context, state) {
                    print(state);
                    if (state is FavouritesInitial)
                      context.read<FavouritesBloc>().add(FavouritesRequest());
                    if (state is FavouritesSuccess) {
                      return SavedTrainList(
                        trains: state.trains,
                        savedTrainType: SavedTrainType.favourites,
                      );
                    }

                    if (state is FavouritesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is FavouritesFailed) {}

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
