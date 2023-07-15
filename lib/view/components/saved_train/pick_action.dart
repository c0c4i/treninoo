import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/view/components/saved_train/pick_action_row.dart';

import '../../../bloc/favourites/favourites_bloc.dart';
import '../../../bloc/favourites/favourites_event.dart';
import '../../../bloc/recents/recents.dart';
import '../../../enum/saved_train_type.dart';
import '../../../model/SavedTrain.dart';
import '../../router/routes_names.dart';
import '../../style/typography.dart';

class SavedTrainPickAction {
  static show({
    required BuildContext context,
    required SavedTrain? savedTrain,
    required SavedTrainType type,
  }) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  Text(
                    "${savedTrain!.trainType} ${savedTrain.trainCode}",
                    style: Typo.titleHeavy,
                  ),
                  SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  if (type == SavedTrainType.favourites)
                    PickActionRow(
                      icon: Icons.subject_rounded,
                      data: savedTrain.description == null
                          ? 'Aggiungi descrizione'
                          : 'Modifica descrizione',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          RoutesNames.editDescription,
                          arguments: savedTrain,
                        ).then(
                          (value) => context
                              .read<FavouritesBloc>()
                              .add(FavouritesRequest()),
                        );
                      },
                    ),
                  PickActionRow(
                    icon: CupertinoIcons.delete,
                    data: type == SavedTrainType.recents
                        ? 'Rimuovi dai recenti'
                        : 'Rimuovi dai preferiti',
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 500));

                      type == SavedTrainType.recents
                          ? context
                              .read<RecentsBloc>()
                              .add(DeleteRecent(savedTrain: savedTrain))
                          : context
                              .read<FavouritesBloc>()
                              .add(DeleteFavourite(savedTrain: savedTrain));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
