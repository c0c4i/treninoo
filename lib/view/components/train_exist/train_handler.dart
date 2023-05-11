import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/exist/exist.dart';
import '../../../bloc/recents/recents.dart';
import '../../../model/SavedTrain.dart';
import '../../router/routes_names.dart';
import '../dialog/remove_train_dialog.dart';
import '../loading_dialog.dart';

class HandleExistBloc extends StatelessWidget {
  const HandleExistBloc({
    Key key,
    @required this.child,
    this.showRemove,
  }) : super(key: key);

  final Widget child;
  final bool showRemove;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExistBloc, ExistState>(
      listener: (context, state) {
        if (state is ExistSuccess) {
          LoadingDialog.hide(context);
          SavedTrain savedTrain = SavedTrain.fromTrainInfo(state.trainInfo);
          // TODO: Refactor to repository
          // addTrain(savedTrain, SavedTrainType.recents);
          context.read<RecentsBloc>().add(RecentsRequest());
          Navigator.pushNamed(
            context,
            RoutesNames.status,
            arguments: savedTrain,
          );
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
