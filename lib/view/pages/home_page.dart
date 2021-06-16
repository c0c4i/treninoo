import 'package:flutter/material.dart';
import 'package:treninoo/view/pages/Favourites.dart';
import 'package:treninoo/view/pages/SolutionsSearch.dart';
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
    SearchTrainPage(),
    SolutionsSearch(),
    Favourites()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust_rounded),
            label: 'Stato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Ricerca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Preferiti',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
