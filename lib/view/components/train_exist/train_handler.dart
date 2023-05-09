import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/repository/train.dart';

import '../../../bloc/exist/exist.dart';
import '../../../bloc/recents/recents.dart';
import '../../../model/SavedTrain.dart';
import '../../../utils/shared_preference_methods.dart';
import '../../router/routes_names.dart';
import '../dialog/remove_train_dialog.dart';
import '../loading_dialog.dart';

class HandleExistBloc extends StatelessWidget {
  const HandleExistBloc({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExistBloc, ExistState>(
      listener: (context, state) {
        if (state is ExistSuccess) {
          LoadingDialog.hide(context);
          SavedTrain savedTrain = SavedTrain.fromTrainInfo(state.trainInfo);
          addTrain(savedTrain, SavedTrainType.recents);
          Navigator.pushNamed(
            context,
            RoutesNames.status,
            arguments: savedTrain,
          ).then((value) {
            context.read<RecentsBloc>().add(RecentsRequest());
          });
          return;
        }

        if (state is ExistFailed) {
          LoadingDialog.hide(context);
          RemoveTrainDialog.show(
            context,
            savedTrain: state.savedTrain,
            savedTrainType: state.type,
          );
        }

        if (state is ExistLoading) LoadingDialog.show(context);
      },
      child: child,
    );
  }
}
