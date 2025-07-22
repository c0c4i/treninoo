import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/solutions/horizontal_hour_selector.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class BeautifulDatePickerDialog {
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
        isScrollControlled: true,
      );
}

class _TimePickerContent extends StatefulWidget {
  const _TimePickerContent({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  final DateTime initialDate;

  @override
  State<_TimePickerContent> createState() => _TimePickerContentState();
}

class _TimePickerContentState extends State<_TimePickerContent> {
  late DateTime _selectedDate;

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
              SizedBox(height: kPadding / 2, width: double.infinity),
              Text(
                "Seleziona data e ora",
                style: Typo.titleHeavy,
              ),
              SizedBox(height: 8, width: double.infinity),
              SizedBox(
                height: 300,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // if you need this
                    side: BorderSide(color: Grey.light, width: 1),
                  ),
                  child: SfDateRangePicker(
                    todayHighlightColor: Grey.normal,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    selectionMode: DateRangePickerSelectionMode.single,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        enableSwipeSelection: false, firstDayOfWeek: 1),
                    showNavigationArrow: true,
                    navigationMode: DateRangePickerNavigationMode.snap,
                    onSelectionChanged: (args) {
                      setState(() {
                        _selectedDate = args.value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: kPadding / 2, width: double.infinity),
              SizedBox(
                height: 60,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // if you need this
                    side: BorderSide(color: Grey.light, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
                    child: HorizontalHourSelector(
                      initialDate: _selectedDate,
                      onHourSelected: (hour) {
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            hour,
                          );
                        });
                      },
                    ),
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
