// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:treninoo/controller/notifiers.dart';

// import 'package:treninoo/view/pages/Favourites.dart';
// import 'package:treninoo/view/pages/TrainSearch.dart';
// import 'package:treninoo/view/pages/SolutionsSearch.dart';
// import 'package:treninoo/view/style/theme.dart';

// import 'package:treninoo/utils/utils.dart';
// import 'package:treninoo/utils/core.dart';

// int index;

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   SharedPrefJson();
//   SharedPreferences.getInstance().then((prefs) {
//     String theme = prefs.getString("theme");
//     index = prefs.getInt("page");
//     ThemeData t;

//     if (theme == null) {
//       t = lightTheme;
//       theme = "Light";
//     } else {
//       t = getThemeFromString(theme);
//     }

//     if (index == null) {
//       index = 0;
//     }

//     runApp(MultiProvider(
//       providers: [
//         ChangeNotifierProvider<SingleNotifier>(
//           create: (_) => SingleNotifier(theme, index),
//         ),
//         ChangeNotifierProvider<ThemeNotifier>(
//           create: (_) => ThemeNotifier(t),
//         )
//       ],
//       child: MyApp(),
//     ));
//   });
// }

// void setAndroidColor(ThemeData t) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       systemNavigationBarColor: t.canvasColor,
//       systemNavigationBarIconBrightness: t.brightness));
// }

// class MyApp extends StatefulWidget {
//   MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   FocusNode myFocusNode;

//   TrainSearch search;
//   SolutionsSearch solutions;
//   Favourites favourites;
//   List<Widget> pages;
//   Widget currentPage;

//   final PageStorageBucket bucket = PageStorageBucket();

//   @override
//   void initState() {
//     search = TrainSearch();
//     solutions = SolutionsSearch();
//     favourites = Favourites();
//     pages = [search, solutions, favourites];

//     _selectedIndex = index;
//     currentPage = pages[_selectedIndex];

//     super.initState();
//     // final provider = Provider.of<SingleNotifier>(context);
//   }

//   int _selectedIndex;
//   // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       currentPage = pages[index];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//     setAndroidColor(themeNotifier.getTheme());

//     return GestureDetector(
//       onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
//       child: MaterialApp(
//         title: 'Treninoo',
//         debugShowCheckedModeBanner: false,
//         theme: themeNotifier.getTheme(),
//         builder: (context, child) => MediaQuery(
//             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//             child: child),
//         localizationsDelegates: [GlobalMaterialLocalizations.delegate],
//         supportedLocales: [const Locale('it')],
//         home: Scaffold(
//           body: PageStorage(
//             child: currentPage,
//             bucket: bucket,
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.adjust_outlined),
//                 label: 'Stato',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 label: 'Soluzioni',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite_border_outlined),
//                 label: 'Preferiti',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//           ),
//         ),
//       ),
//     );
//   }
// }
