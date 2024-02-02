import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/enum/saved_train_type.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/train_card.dart';
import 'package:treninoo/view/style/theme.dart';

class ReorderFavouritesPage extends StatefulWidget {
  @override
  _ReorderFavouritesPageState createState() => _ReorderFavouritesPageState();
}

class _ReorderFavouritesPageState extends State<ReorderFavouritesPage> {
  _ReorderFavouritesPageState() : super();

  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.04, animValue)!;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: child,
      );
    }

    void reorderFavorites(int oldIndex, int newIndex) {
      context.read<FavouritesBloc>().add(ReorderFavourites(
            oldIndex: oldIndex,
            newIndex: newIndex,
          ));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              BeautifulAppBar(
                title: "Riordina preferiti",
              ),
              SizedBox(height: kPadding / 2),
              Expanded(
                child: BlocBuilder<FavouritesBloc, FavouritesState>(
                  builder: (context, state) {
                    if (state is FavouritesSuccess && state.trains.isNotEmpty) {
                      return ReorderableListView(
                        physics: ClampingScrollPhysics(),
                        proxyDecorator: proxyDecorator,
                        onReorder: reorderFavorites,
                        children: [
                          for (SavedTrain train in state.trains)
                            TrainCard(
                              key: Key(train.trainCode),
                              savedTrain: train,
                              type: SavedTrainType.favourites,
                              enabled: false,
                            ),
                        ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
