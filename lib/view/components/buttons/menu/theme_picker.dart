import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class ThemePicker extends StatefulWidget {
  const ThemePicker({super.key});

  @override
  State<ThemePicker> createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AdaptiveThemeMode.values.length,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController.index = AdaptiveTheme.of(context).mode.index;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // if you need this
        side: BorderSide(
          color: Grey.light,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius - kPadding / 2),
            color: Primary.lightest2,
          ),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelColor: Primary.normal,
          unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
          onTap: (index) {
            AdaptiveTheme.of(context).setThemeMode(
              AdaptiveThemeMode.values[index],
            );

            final isDark = AdaptiveTheme.of(context).mode.isDark;
            Utils.setAppBarBrightness(isDark);
            setState(() {});
          },
          tabs: [
            for (var mode in AdaptiveThemeMode.values)
              Tab(
                child: Text(
                  mode.modeName,
                  style: Typo.bodyHeavy,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
