import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treninoo/model/Strike.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class StrikeCard extends StatelessWidget {
  const StrikeCard({super.key, required this.strike});

  final Strike strike;

  String? get date {
    if (strike.startDate == null) return null;
    if (strike.endDate == null)
      return DateFormat('dd/MM/yyyy').format(strike.startDate!);
    if (strike.startDate == strike.endDate)
      return DateFormat('dd/MM/yyyy').format(strike.startDate!);
    return '${DateFormat('dd/MM/yyyy').format(strike.startDate!)} - ${DateFormat('dd/MM/yyyy').format(strike.endDate!)}';
  }

  Color get locationColor {
    if (strike.where == null) return Grey.dark;
    if (strike.where!.toLowerCase().contains('nazionale')) {
      return Color(0xFF008AD8);
    }

    return Color(0xFF3DAE2B);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kPadding / 2,
      ),
      child: BeautifulCard(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      date ?? '',
                      style: Typo.bodyHeavy.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      strike.where?.toUpperCase() ?? '',
                      style: Typo.bodyHeavy.copyWith(color: locationColor),
                    ),
                  ],
                ),
              ),
              Text(
                strike.category?.toString() ?? '',
                style: Typo.bodyHeavy,
              ),
              const SizedBox(height: kPadding / 2),
              Text(
                strike.description?.toString() ?? '',
                style: Typo.bodyHeavy.copyWith(color: Grey.dark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
