import 'package:flutter/material.dart';
// import 'package:train_status/main.dart';
// import 'utils.dart';

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
        child: ListView(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 15),
                title: Text(
                  'Impostazioni',
                  style: TextStyle(
                    fontSize: 45,
                  ),
                ),
              ),
              /*
              ListTile(
                title: Text('Forza tema scuro'),
                subtitle: Text('L\' applicazione si adatta automaticamente al tema impostato dal sistema operativo'),
                trailing: Switch(
                  value: true,
                  activeColor: Theme.of(context).buttonColor,
                  onChanged: (value) {
                    setState(() {
                      //darkThemeEnabled = value;
                      //RestartWidget.restartApp(context);
                      _showDialog(value);
                    });
                  },
                ),
              ),
              */
            ],
          ),
        ),
    );
  }

/*  CONFERMA CAMBIO TEMA
  void _showDialog(bool value) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Tema Scuro"),
          content: new Text("Riavviare l'applicazione per effettuare i cambiamenti?"),
          contentPadding: EdgeInsets.only(bottom: 0, top: 24, right: 24, left: 24),
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
*/

}