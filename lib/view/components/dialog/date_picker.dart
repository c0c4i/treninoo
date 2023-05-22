import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class BeautifulDatePickerDialog {
  static Future<DateTime> show({
    @required BuildContext context,
    @required DateTime initialDate,
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
        isScrollControlled: true,
      );
}

class _TimePickerContent extends StatefulWidget {
  const _TimePickerContent({
    Key key,
    this.initialDate,
  }) : super(key: key);

  final DateTime initialDate;

  @override
  State<_TimePickerContent> createState() => _TimePickerContentState();
}

class _TimePickerContentState extends State<_TimePickerContent> {
  DateTime _selectedDate;

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
                "Seleziona il giorno di partenza",
                style: Typo.titleHeavy,
              ),
              SizedBox(height: 8, width: double.infinity),
              SizedBox(
                height: 400,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // if you need this
                    side: BorderSide(color: Grey.light, width: 1),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    locale: 'it',
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _selectedDate,
                    headerStyle: HeaderStyle(formatButtonVisible: false),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Primary.normal,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Primary.lighter,
                        shape: BoxShape.circle,
                      ),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                      });
                    },
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
