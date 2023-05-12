import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/view/style/theme.dart';
import '../../../repository/saved_train.dart';
import '../../style/typography.dart';

class SelectStartPageDialog {
  static final Map<int, String> _pages = {
    0: "Stato",
    1: "Ricerca",
    2: "Stazione",
    3: "Preferiti",
  };

  static show({
    @required BuildContext context,
  }) async {
    // TODO: Convert to BloC management
    int selected = context.read<SavedTrainRepository>().sharedPrefs.firstPage;

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
                    "Seleziona la pagina iniziale",
                    style: Typo.titleHeavy,
                  ),
                  SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  for (var page in _pages.entries)
                    RadioListTile(
                      title: Text(page.value),
                      value: page.key,
                      groupValue: selected,
                      selected: selected == page.key,
                      onChanged: (value) {
                        selected = value;
                        context
                            .read<SavedTrainRepository>()
                            .sharedPrefs
                            .firstPage = value;
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadius),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kPadding,
                      ),
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
