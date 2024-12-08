import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/theme.dart';
import 'dart:math';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class BeautifulDateTimePickerDialog {
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
  }) async =>
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kRadius),
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
        padding: const EdgeInsets.all(kPadding),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: kPadding, width: double.infinity),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Seleziona data e ora",
                      style: Typo.titleHeavy,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: IconButton(
                      icon: Icon(Icons.refresh_rounded),
                      onPressed: () {
                        Navigator.pop(context, DateTime.now());
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(width: kPadding),
                ],
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
                    mode: CupertinoDatePickerMode.dateAndTime,
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
