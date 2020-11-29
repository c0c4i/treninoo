import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treninoo/controller/notifiers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:treninoo/utils/core.dart';
// import 'package:train_status/main.dart';
// import 'utils.dart';

enum ThemeType { Light, Dark, Auto }

final List<String> themes = ['Light', 'Dark'];
final List<String> pages = ['Stato', "Ricerca", "Preferiti"];

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // String currentTheme = "Auto";
  // List themeList = ["Auto"];
  // List themeList = ["Ligth", "Dark", "Auto"];

  // String currentFirstPage = "Stato";
  // List firstPageList = ["Stato"];
  // List firstPageList = ["Stato", "Ricerca", "Preferiti"];

  // ThemeType _character = ThemeType.Auto;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Impostazioni"),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                'Impostazioni',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20),
              title: Text('Tema'),
              subtitle: Text('Seleziona il tema dell\'applicazione'),
              onTap: () => _showThemeSelection(context),
            ),
            ListTile(
                contentPadding: EdgeInsets.only(left: 20),
                title: Text('Schermata iniziale'),
                subtitle: Text('Seleziona la schermata inziale'),
                onTap: () => _showStartPageSelection(context)),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contatti',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        color: Color(0xFFD44638),
                        onPressed: _openGmail,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'Gmail',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        color: Color(0xFF0E76A8),
                        onPressed: _openLinkedIn,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'LinkedIn',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'App',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        color: Color(0xFF000000),
                        onPressed: _openCode,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'Code',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        color: Color(0xFFF0AD4E),
                        onPressed: _openDonate,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'Donate',
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// CONFERMA CAMBIO TEMA
  void _showDialog(bool value) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Tema Scuro"),
          content: new Text(
              "Riavviare l'applicazione per effettuare i cambiamenti?"),
          contentPadding:
              EdgeInsets.only(bottom: 0, top: 24, right: 24, left: 24),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Chiudi",
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.body1.color,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

_openGmail() async {
  const url = 'mailto:<samuele.besoli.sb@gmail.com>';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_openLinkedIn() async {
  const url = 'https://www.linkedin.com/in/samuele-besoli/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_openCode() async {
  const url = 'https://github.com/c0c4i/treninoo';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_openDonate() async {
  const url = 'https://paypal.me/SamueleBesoli';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_showThemeSelection(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      var _singleNotifier = Provider.of<SingleNotifier>(context);
      var _themeNotifier = Provider.of<ThemeNotifier>(context);
      return AlertDialog(
          title: Text("Seleziona tema"),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: themes
                    .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: _singleNotifier.currentTheme,
                          selected: _singleNotifier.currentTheme == e,
                          onChanged: (value) {
                            if (value != _singleNotifier.currentTheme) {
                              _singleNotifier.updateTheme(value);
                              _themeNotifier
                                  .setTheme(getThemeFromString(value));
                              SharedPreferences.getInstance().then(
                                  (prefs) => prefs.setString("theme", value));
                              Navigator.of(context).pop();
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ));
    });

_showStartPageSelection(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      var _singleNotifier = Provider.of<SingleNotifier>(context);
      // var _themeNotifier = Provider.of<ThemeNotifier>(context);
      return AlertDialog(
          title: Text("Seleziona schermata"),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: pages
                    .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: pages[_singleNotifier.startPage],
                          selected:
                              _singleNotifier.startPage == pages.indexOf(e),
                          onChanged: (value) {
                            if (value != _singleNotifier.startPage) {
                              _singleNotifier.updatePage(pages.indexOf(value));
                              print(_singleNotifier.startPage);
                              SharedPreferences.getInstance().then((prefs) =>
                                  prefs.setInt("page", pages.indexOf(value)));
                              Navigator.of(context).pop();
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ));
    });
