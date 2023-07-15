import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/model/Station.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../bloc/edit_description/edit_description.dart';
import '../components/buttons/text_button.dart';

class EditDescriptionPage extends StatefulWidget {
  final SavedTrain? savedTrain;

  EditDescriptionPage({Key? key, this.savedTrain}) : super(key: key);

  @override
  _EditDescriptionPageState createState() => _EditDescriptionPageState();
}

class _EditDescriptionPageState extends State<EditDescriptionPage> {
  Station? selected;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.savedTrain!.description!;
    super.initState();
  }

  onSave() {
    if (context.read<EditDescriptionBloc>() is EditDescriptionLoading) return;
    if (_controller.text.isEmpty) return;

    SavedTrain savedTrain = widget.savedTrain!.copyWith(
      description: _controller.text,
    );

    context.read<EditDescriptionBloc>().add(
          EditDescriptionRequest(savedTrain: savedTrain),
        );
  }

  onRemove() {
    if (context.read<EditDescriptionBloc>() is EditDescriptionLoading) return;
    SavedTrain savedTrain = widget.savedTrain!.copyWith(
      description: null,
    );

    context.read<EditDescriptionBloc>().add(
          EditDescriptionRequest(savedTrain: savedTrain),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: BlocListener<EditDescriptionBloc, EditDescriptionState>(
                listener: (context, state) {
                  if (state is EditDescriptionSuccess) {
                    Navigator.pop(context);
                  }

                  if (state is EditDescriptionFailed) {
                    // Scaffold.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(state.error),
                    //   ),
                    // );
                  }
                },
                child: Column(
                  children: <Widget>[
                    BeautifulAppBar(
                      title: "Descrizione",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kPadding),
                          child: Text(
                            "Aggiungi una descrizione al treno selezionato",
                            style:
                                Typo.subheaderLight.copyWith(color: Grey.dark),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Aggiungi un commento',
                          ),
                          controller: _controller,
                          enabled: context.watch<EditDescriptionBloc>()
                              is! EditDescriptionLoading,
                          maxLines: 8,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        SizedBox(height: 16),
                        ActionButton(
                          title: "Salva",
                          onPressed: onSave,
                        ),
                        SizedBox(height: 16),
                        ActionTextButton(
                          title: "Rimuovi descrizione",
                          onPressed: onRemove,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
