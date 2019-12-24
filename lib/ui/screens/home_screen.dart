import 'package:flutter/material.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(appLocal.translate(LocalKeys.APP_NAME)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: selectedColor(),
          unselectedItemColor: notSeletedColor(),
          currentIndex: _currentIndex,
          onTap: onBottomItemSelected,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(appLocal.translate(LocalKeys.ITINERARIES))),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text(appLocal.translate(LocalKeys.MAP))),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                title: Text(appLocal.translate(LocalKeys.MY_PLAN))),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text(appLocal.translate(LocalKeys.EXPLORE)))
          ],
        ),
        body: Container(
          color: Colors.greenAccent,
          child: Center(
            child: Text(
                "${appLocal.translate(LocalKeys.APP_NAME)}: $_currentIndex"),
          ),
        ));
  }

  void onBottomItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Color notSeletedColor() {
    return Coolor.NAV_NOT_SEL_COL;
  }

  Color selectedColor() {
    return Coolor.NAV_SEL_COL;
  }
}
