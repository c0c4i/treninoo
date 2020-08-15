import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:treninoo/favourites.dart';
import 'package:treninoo/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';
import 'search.dart';
import 'searchSolutions.dart';
// import 'utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // appSettings = await SharedPreferences.getInstance();
  //runApp(RestartWidget(child: MyApp()));
  var sharedMemory = SharedPrefJson();
  runApp(MyApp());
}
/*
class RestartWidget extends StatefulWidget {
  final Widget child;
  RestartWidget({this.child});
  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }
  @override
  _RestartWidgetState createState() => new _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = new UniqueKey();
  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      key: key,
      child: widget.child,
    );
  }
}
*/

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FocusNode myFocusNode;

  Search search;
  SearchSolutions solutions;
  Favourites favourites;
  List<Widget> pages;
  Widget currentPage;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    search = Search();
    solutions = SearchSolutions();
    favourites = Favourites();
    pages = [search, solutions, favourites];

    currentPage = search;

    super.initState();
  }

  int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        // print("eccomi");
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
      },
      child: MaterialApp(
        title: 'Treninoo',
        darkTheme: CustomTheme.darkMode,
        theme: CustomTheme.defaultMode,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        home: Scaffold(
          body: PageStorage(
            child: currentPage,
            bucket: bucket,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(OMIcons.train),
                title: Text('Stato'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Ricerca'),
              ),
              BottomNavigationBarItem(
                icon: Icon(OMIcons.favorite),
                title: Text('Preferiti'),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class Data {
  final int id;
  bool expanded;
  final String title;
  Data({this.id, this.expanded, this.title});
}
