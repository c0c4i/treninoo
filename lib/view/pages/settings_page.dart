import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/components/buttons/menu/menu_button_switch.dart';
import 'package:treninoo/view/components/header.dart';
import 'package:treninoo/view/style/theme.dart';

import '../components/buttons/menu/menu_button_click.dart';
import '../components/dialog/select_start_page.dart';
import '../router/routes_names.dart';

enum ThemeType { Light, Dark, Auto }

final List<String> themes = ['Light', 'Dark'];
final List<String> pages = ['Stato', "Ricerca", "Stazione" "Preferiti"];

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

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

// _openGmail() async {
//   const url = 'mailto:<samuele.besoli.sb@gmail.com>';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// _openLinkedIn() async {
//   const url = 'https://www.linkedin.com/in/samuele-besoli/';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// _openCode() async {
//   const url = 'https://github.com/c0c4i/treninoo';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// _openDonate() async {
//   const url = 'https://paypal.me/SamueleBesoli';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// _showThemeSelection(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) {
//       var _singleNotifier = Provider.of<SingleNotifier>(context);
//       var _themeNotifier = Provider.of<ThemeNotifier>(context);
//       return AlertDialog(
//           title: Text("Seleziona tema"),
//           content: SingleChildScrollView(
//             child: Container(
//               width: double.infinity,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: themes
//                     .map((e) => RadioListTile(
//                           title: Text(e),
//                           value: e,
//                           groupValue: _singleNotifier.currentTheme,
//                           selected: _singleNotifier.currentTheme == e,
//                           onChanged: (value) {
//                             if (value != _singleNotifier.currentTheme) {
//                               _singleNotifier.updateTheme(value);
//                               _themeNotifier
//                                   .setTheme(getThemeFromString(value));
//                               SharedPreferences.getInstance().then(
//                                   (prefs) => prefs.setString("theme", value));
//                               Navigator.of(context).pop();
//                             }
//                           },
//                         ))
//                     .toList(),
//               ),
//             ),
//           ));
//     });

// _showStartPageSelection(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) {
//       // var _singleNotifier = Provider.of<SingleNotifier>(context);
//       // var _themeNotifier = Provider.of<ThemeNotifier>(context);
//       return AlertDialog(
//           title: Text("Seleziona schermata"),
//           content: SingleChildScrollView(
//             child: Container(
//               width: double.infinity,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: pages
//                     .map(
//                       (e) => RadioListTile(
//                         title: Text(e),
//                         value: e,
//                         groupValue: pages[0],
//                         selected: 0 == pages.indexOf(e),
//                         onChanged: (value) {
//                           // if (value != _singleNotifier.startPage) {
//                           //   _singleNotifier.updatePage(pages.indexOf(value));
//                           //   print(_singleNotifier.startPage);
//                           //   SharedPreferences.getInstance().then((prefs) =>
//                           //       prefs.setInt("page", pages.indexOf(value)));
//                           //   Navigator.of(context).pop();
//                           // }
//                         },
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           ));
//     });
