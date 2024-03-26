import 'package:flutter/material.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import '../../style/typography.dart';

class TrainTypeDialog {
  static show({
    required BuildContext context,
    required TrainType initialType,
  }) async {
    return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(kPadding)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kPadding / 2,
                    width: double.infinity,
                  ),
                  Text(
                    "Seleziona tipo di treno",
                    style: Typo.titleHeavy,
                  ),
                  SizedBox(
                    height: kPadding,
                    width: double.infinity,
                  ),
                  BeautifulCard(
                    child: Column(
                      children: [
                        for (var type in TrainType.values)
                          Column(
                            children: [
                              ListTile(
                                title: Text(type.label),
                                selected: type == initialType,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadius),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: kPadding,
                                ),
                                trailing: type == initialType
                                    ? Icon(
                                        Icons.check,
                                        color: Primary.normal,
                                      )
                                    : null,
                                onTap: () {
                                  Navigator.pop(context, type);
                                },
                              ),
                              if (type != TrainType.values.last)
                                const Divider(thickness: 1, height: 1),
                            ],
                          )
                      ],
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
