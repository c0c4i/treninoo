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

  void onPageSwipe(int index) {
    print("Oh $index");
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
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
        icon: Icon(Icons.favorite_outline_rounded),
        label: 'Preferiti',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        onPageSwipe(index);
      },
      children: <Widget>[
        SearchTrainPage(),
        SolutionsSearch(),
        Favourites(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }
}
