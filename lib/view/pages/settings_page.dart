import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/buttons/menu/menu_button_switch.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/style/theme.dart';

import '../components/buttons/menu/menu_button_click.dart';
import '../components/dialog/select_start_page.dart';
import '../components/predicted_arrival/enable_predicted_arrival.dart';
import '../router/routes_names.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Header(
                title: "Impostazioni",
                description:
                    "Qui puoi modificare l'app a tuo piacimento per renderla più comoda",
              ),
              SizedBox(height: 16),
              MenuButtonSwitch(
                title: "Dark Mode",
                description: "Attiva il tema scuro",
                value: AdaptiveTheme.of(context).mode.isDark,
                onChanged: (isDark) {
                  isDark
                      ? AdaptiveTheme.of(context).setDark()
                      : AdaptiveTheme.of(context).setLight();

                  Utils.setAppBarBrightness(isDark);
                  setState(() {});
                },
              ),
              SizedBox(height: kPadding),
              MenuButtonClick(
                title: "Schermata iniziale",
                description: "Seleziona la schermata di avvio",
                onPressed: () => SelectStartPageDialog.show(context: context),
              ),
              SizedBox(height: kPadding),
              MenuButtonClick(
                title: "Invia un feedback",
                description:
                    "Dimmi ciò che pensi di questa app, segnala problemi o funzionalità che ti piacerebbero",
                onPressed: () {
                  Navigator.pushNamed(context, RoutesNames.sendFeedback);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
