import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../view/style/theme.dart';
import '../view/pages/search.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  OMIcons.train,
                  color: CustomColors.customRed,
                  size: 125,
                ),
                Text(
                  'Train Status',
                  style: TextStyle(color: CustomColors.customRed, fontSize: 30),
                )
              ],
            ),
          ),
        )),
        Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: CustomColors.customRed,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 20, bottom: 20),
                        color: Colors.white,
                        textColor: CustomColors.customRed,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text(
                          'Login with Google',
                          style: TextStyle(
                              fontSize: 25, color: CustomColors.customRed),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      splashColor: Colors.white,
                      focusColor: Colors.white,
                      child: RaisedButton(
                        color: CustomColors.customRed,
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 20, bottom: 20),
                        textColor: CustomColors.customRed,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            side: BorderSide(
                                width: 2.0,
                                color: Colors.white,
                                style: BorderStyle.solid)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(),
                            ),
                          );
                        },
                        child: Text(
                          'Skip Login',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
      ],
    )));
  }
}
