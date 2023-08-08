import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/cubit/show_feature.dart';
import 'package:treninoo/view/pages/favourites_page.dart';
import 'package:treninoo/view/pages/settings_page.dart';
import 'package:treninoo/view/pages/search_solutions_page.dart';
import 'package:treninoo/view/pages/search_station_page.dart';
import 'package:treninoo/view/pages/search_train_page.dart';

import '../../cubit/first_page.dart';
import '../../cubit/predicted_arrival.dart';
import '../components/dialog/new_feature.dart';

/// This is the stateful widget that the main application instantiates.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomePage> {
  late int _selectedIndex;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = context.read<FirstPageCubit>().state;
    pageController = PageController(
      initialPage: _selectedIndex,
      keepPage: true,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 600));
      bool showFeature = context.read<ShowFeatureCubit>().state;
      bool predictedArrival = context.read<PredictedArrivalCubit>().state;
      if (showFeature && !predictedArrival) {
        context.read<ShowFeatureCubit>().update(false);
        BeautifulNewFeatureDialog.show(context: context);
      }
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    SearchTrainPage(),
    SearchSolutionsPage(),
    SearchStationPage(),
    FavouritesPage(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController!.animateToPage(index,
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
        icon: Icon(Icons.tune_outlined),
        label: 'Generali',
      ),
    ];
  }

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
