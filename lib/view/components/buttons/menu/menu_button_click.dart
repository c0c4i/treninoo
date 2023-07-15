import 'package:flutter/material.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/typography.dart';

class MenuButtonClick extends StatelessWidget {
  const MenuButtonClick({
    Key? key,
    required this.title,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Typo.subheaderHeavy.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                description,
                style: Typo.bodyLight.copyWith(
                  color: Grey.dark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
