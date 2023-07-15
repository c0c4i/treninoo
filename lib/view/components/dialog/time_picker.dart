import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class BeautifulTimePickerDialog {
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
  }) async =>
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (_) => _TimePickerContent(
          initialDate: initialDate,
        ),
      );
}

class _TimePickerContent extends StatefulWidget {
  const _TimePickerContent({
    Key? key,
    this.initialDate,
  }) : super(key: key);

  final DateTime? initialDate;

  @override
  State<_TimePickerContent> createState() => _TimePickerContentState();
}

class _TimePickerContentState extends State<_TimePickerContent> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: kPadding, width: double.infinity),
              Text(
                "Seleziona l’ora di partenza",
                style: Typo.titleHeavy,
              ),
              SizedBox(height: 8, width: double.infinity),
              SizedBox(
                height: 224,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // if you need this
                    side: BorderSide(
                      color: Grey.light,
                      width: 1,
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: _selectedDate,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        _selectedDate = newDateTime;
                      });
                    },
                    use24hFormat: true,
                  ),
                ),
              ),
              SizedBox(height: kPadding, width: double.infinity),
              ActionButton(
                title: "Salva",
                onPressed: () {
                  Navigator.pop(context, _selectedDate);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
