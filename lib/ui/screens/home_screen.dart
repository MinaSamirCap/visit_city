import 'package:flutter/material.dart';
import 'package:visit_city/res/assets_path.dart';
import '../../ui/widget/mian_drawer_widget.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  AppLocalizations _appLocal;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
        key: _drawerKey,
        drawer: Drawer(child: MainDrawerWidget(_appLocal, onMenuItemSelected)),
        bottomNavigationBar: getBottomNavigation(),
        body: getBody());
  }

  void onMenuItemSelected(String title) {
    print(title);
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

  BottomNavigationBar getBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: selectedColor(),
      unselectedItemColor: notSeletedColor(),
      currentIndex: _currentIndex,
      onTap: onBottomItemSelected,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(_appLocal.translate(LocalKeys.ITINERARIES))),
        BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text(_appLocal.translate(LocalKeys.MAP))),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text(_appLocal.translate(LocalKeys.MY_PLAN))),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(_appLocal.translate(LocalKeys.EXPLORE)))
      ],
    );
  }

  Widget getBody() {
    return Stack(
      children: <Widget>[
        headerImage(),
        menuIcon(),
        blueLogo(),
        itinerariesText(),
        Center(
          child: Text(
              "${_appLocal.translate(LocalKeys.APP_NAME)}: $_currentIndex"),
        ),
      ],
    );
  }

  Widget headerImage() {
    return Image.network(
        "https://assets.cairo360.com/app/uploads/2011/01/article_original_1448_2011181_423717764-600x323.jpeg");
  }

  Widget menuIcon() {
    return Positioned.directional(
      start: 3,
      top: 15,
      child: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          /// to open the drawer programatically.
          //Scaffold.of(context).openDrawer();
          _drawerKey.currentState.openDrawer();
        },
      ),
      textDirection: TextDirection.ltr,
    );
  }

  Widget blueLogo() {
    return Positioned(
      left: 70,
      right: 70,
      top: 70,
      child: Image.asset(AssPath.LOGO_BLUE),
    );
  }

  Widget itinerariesText() {
    return Positioned(
      top: 170,
      left: 0,
      right: 0,
      child: Center(
          child: Text(
        _appLocal.translate(LocalKeys.IN_3_ITINERARIES),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Coolor.GREY_DARK),
      )),
    );
  }
}
