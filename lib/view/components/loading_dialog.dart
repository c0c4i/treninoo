import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  static void hideWithSuccess(BuildContext context) {
    Navigator.pop(context);
  }

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius),
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
