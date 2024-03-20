import 'package:flutter/material.dart';
import 'package:treninoo/view/components/textfield.dart';
import 'package:treninoo/view/style/colors/black.dart';
import 'package:treninoo/view/style/theme.dart';

import '../../style/colors/grey.dart';
import '../../style/typography.dart';

class StationPickerDialog {
  static Future<void> show({
    required BuildContext context,
  }) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kRadius),
        ),
      ),
      builder: (_) => StationPickerContent(),
    );
  }
}

class StationPickerContent extends StatefulWidget {
  const StationPickerContent({super.key});

  @override
  State<StationPickerContent> createState() => _StationPickerContentState();
}

class _StationPickerContentState extends State<StationPickerContent> {
  final FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // TODO: Uncomment when ready to use
    // searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPadding * 1.2, horizontal: kPadding * 1.2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.86,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seleziona stazione",
                    style: Typo.titleHeavy,
                  ),
                  CircleAvatar(
                    backgroundColor: Grey.lighter,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.close_rounded,
                        size: 22,
                        color: Black.normal,
                      ),
                      constraints: BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Grey.darker,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8, width: double.infinity),
              BeautifulTextField(
                labelText: "Ricerca",
                focusNode: searchFocus,
                // controller: searchController,
                keyboardType: TextInputType.number,
              )
            ],
          ),
        ),
      ),
    );
  }
}
