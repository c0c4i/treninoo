import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treninoo/controller/notifiers.dart';
import 'package:treninoo/favourites.dart';
import 'package:treninoo/newutils.dart';
import 'package:treninoo/utils.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';
import 'search.dart';
import 'searchSolutions.dart';
// import 'utils.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // // appSettings = await SharedPreferences.getInstance();
//   // //runApp(RestartWidget(child: MyApp()));
//   // var sharedMemory = SharedPrefJson();
//   runApp(MyApp());
// }

int index;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefJson();
  SharedPreferences.getInstance().then((prefs) {
    String theme = prefs.getString("theme");
    index = prefs.getInt("page");
    ThemeData t;

    if (theme == null) {
      t = lightTheme;
      theme = "Light";
    } else {
      t = getThemeFromString(theme);
    }

    if (index == null) {
      index = 0;
    }

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<SingleNotifier>(
          create: (_) => SingleNotifier(theme, index),
        ),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(t),
        )
      ],
      child: MyApp(),
    ));
  });
}

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

    _selectedIndex = index;
    currentPage = pages[_selectedIndex];

    super.initState();
    // final provider = Provider.of<SingleNotifier>(context);
  }

  int _selectedIndex;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // final provider = Provider.of<SingleNotifier>(context);
    // int _selectedIndex = provider.startPage;
    // currentPage = pages[_selectedIndex];

    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Treninoo',
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('it')],
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
