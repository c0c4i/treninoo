import 'package:flutter/material.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class DescriptionFooter extends StatelessWidget {
  const DescriptionFooter({Key? key, required this.description})
      : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 1, height: 1),
        Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Text(
            description!,
            style: Typo.bodyHeavy.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
