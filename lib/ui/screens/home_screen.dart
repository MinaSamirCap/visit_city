import 'package:flutter/material.dart';
import 'package:visit_city/general/url_launchers.dart';
import '../../prefs/pref_manager.dart';
import '../../ui/screens/profile_screen.dart';

import '../../ui/screens/qr_code_screen.dart';
import '../../ui/screens/wishlist_screen.dart';
import '../../ui/widget/explore_widget.dart';
import '../../ui/widget/home_widget.dart';
import '../../ui/widget/map_widget.dart';
import '../../ui/widget/plan_widget.dart';
import '../../ui/widget/mian_drawer_widget.dart';
import '../../ui/screens/feedback_screen.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';
import '../../res/coolor.dart';
import '../../ui/screens/useful_contacts_screen.dart';
import '../../ui/screens/mixed_itineraries_screen.dart';
import '../../ui/screens/how_to_use_app_screen.dart';
import '../../ui/screens/fayoum_intro_screen.dart';
import '../../ui/screens/sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<ItineraryModel> list;
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
    list = ItineraryModel.getItinerariesList(_appLocal);
    return Scaffold(
        key: _drawerKey,
        drawer: Drawer(child: MainDrawerWidget(_appLocal, onMenuItemSelected)),
        bottomNavigationBar: getBottomNavigation(),
        body: getBody());
  }

  void onMenuItemSelected(String title) {
    if (title == _appLocal.translate(LocalKeys.FEEDBACK)) {
      Navigator.of(context).pushNamed(FeedbackScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.LOGOUT)) {
      logoutUser();
    } else if (title == _appLocal.translate(LocalKeys.PROFILE)) {
      Navigator.of(context).pushNamed(ProfileScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.WISHLIST)) {
      Navigator.of(context).pushNamed(WishlistScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.GUIDE_BOOK)) {
      launchUrl("https://www.google.com");
    } else if (title == _appLocal.translate(LocalKeys.MIXED_ITE)) {
      Navigator.of(context).pushNamed(MixedItinerariesScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.HOW_TO_USE_APP)) {
      Navigator.of(context).pushNamed(HowToUseAppScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.INTRO_ABOUT_FAYOUM)) {
      Navigator.of(context).pushNamed(FayoumIntroScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.USEFUL_CONTACTS)) {
      Navigator.of(context).pushNamed(UsefulContactsScreen.ROUTE_NAME);
    } else if (title == _appLocal.translate(LocalKeys.QR_CODE)) {
      Navigator.of(context).pushNamed(QrCodeScreen.ROUTE_NAME);
    }
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
            icon: Icon(Icons.explore),
            title: Text(_appLocal.translate(LocalKeys.EXPLORE)))
      ],
    );
  }

  Widget getBody() {
    switch (_currentIndex) {
      case 0:
        return HomeWidget(_appLocal, _drawerKey, list);
      case 1:
        return MapWidget();
      case 2:
        return PlanWidget();
      case 3:
        return ExploreWidget();
    }
    return HomeWidget(_appLocal, _drawerKey, list);
  }

  void logoutUser() async {
    await PrefManager.clearAllData();
    Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
  }
}
