import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/favourites/favourites.dart';
import 'package:treninoo/bloc/recents/recents.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/pages/favourites_page.dart';
import 'package:treninoo/view/pages/settings_page.dart';
import 'package:treninoo/view/pages/search_solutions_page.dart';
import 'package:treninoo/view/pages/search_station_page.dart';
import 'package:treninoo/view/pages/search_train_page.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => RecentsBloc(context.read<TrainRepository>()),
      child: SearchTrainPage(),
    ),
    SearchSolutionsPage(),
    SearchStationPage(),
    BlocProvider(
      create: (context) => FavouritesBloc(context.read<TrainRepository>()),
      child: FavouritesPage(),
    ),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.adjust_rounded),
        label: 'Stato',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        label: 'Ricerca',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.place_outlined),
        label: 'Stazione',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline_rounded),
        label: 'Preferiti',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_rounded),
        label: 'Generali',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: _widgetOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
