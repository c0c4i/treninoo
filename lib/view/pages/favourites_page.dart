import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/components/trains_list.dart';
import 'package:treninoo/view/style/theme.dart';

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Header(
                  title: "I tuoi treni",
                  description:
                      "Qui puoi trovare i treni che hai contrassegnato come preferiti",
                ),
                SizedBox(height: 16),
                BlocBuilder<FavouritesBloc, FavouritesState>(
                  builder: (context, state) {
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
