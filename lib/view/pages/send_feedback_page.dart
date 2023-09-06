import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/textfield.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

import '../../bloc/send_feedback/send_feedback.dart';
import '../components/dialog/thanks_for_feedback.dart';

class SendFeedbackPage extends StatefulWidget {
  SendFeedbackPage({Key? key}) : super(key: key);

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _controller = TextEditingController();

  onSave() {
    if (context.read<SendFeedbackBloc>().state is SendFeedbackLoading) return;
    if (_controller.text.isEmpty) return;
    hideKeyboard();
    context.read<SendFeedbackBloc>().add(
          SendFeedbackRequest(
            feedback: _controller.text,
            email: _emailController.text,
          ),
        );
  }

  hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: hideKeyboard,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: BlocListener<SendFeedbackBloc, SendFeedbackState>(
                listener: (context, state) {
                  if (state is SendFeedbackSuccess) {
                    Navigator.pop(context);
                    ThanksForFeedbackDialog.show(context);
                  }

                  if (state is SendFeedbackFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Ops! Qualcosa è andato storto!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Column(
                  children: <Widget>[
                    BeautifulAppBar(
                      title: "Feedback",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kPadding),
                          child: Text(
                            "Parlaci dei problemi o suggerisci nuove funzionalità che ti piacerebbe avere in futuro",
                            style:
                                Typo.subheaderLight.copyWith(color: Grey.dark),
                          ),
                        ),
                        TextField(
                          controller: _controller,
                          enabled: context.watch<SendFeedbackBloc>().state
                              is! SendFeedbackLoading,
                          maxLines: 8,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        SizedBox(height: kPadding),
                        Text(
                          "Inserisci la tua email (opzionale) se vuoi essere ricontattato",
                          style: Typo.bodyLight.copyWith(color: Grey.dark),
                        ),
                        SizedBox(height: kPadding / 2),
                        BeautifulTextField(
                          labelText: "Email",
                          textCapitalization: TextCapitalization.none,
                          controller: _emailController,
                        ),
                        SizedBox(height: kPadding),
                        ActionButton(
                          title: "Invia",
                          onPressed: onSave,
                          isLoading: context.watch<SendFeedbackBloc>().state
                              is SendFeedbackLoading,
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
