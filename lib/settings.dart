import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:train_status/main.dart';
// import 'utils.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String currentTheme = "Dark";
  List themeList = ["Ligth", "Dark", "Auto"];

  String currentFirstPage = "Stato";
  List firstPageList = ["Stato", "Ricerca", "Preferiti"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12, top: 10, bottom: 15),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Impostazioni',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              ListTile(
                title: Text('Tema'),
                subtitle: Text('Seleziona il tema dell\'applicazione'),
                trailing: DropdownButton(
                  value: currentTheme,
                  items: themeList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentTheme = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Schermata iniziale'),
                subtitle: Text('Seleziona la schermata inziale'),
                trailing: DropdownButton(
                  value: currentFirstPage,
                  items: firstPageList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentFirstPage = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(),
              ),
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
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
