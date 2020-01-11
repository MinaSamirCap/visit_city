import 'package:flutter/material.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../ui/screens/itinerary_details_screen.dart';

class HomeWidget extends StatelessWidget {
  final AppLocalizations _appLocal;
  final GlobalKey<ScaffoldState> _drawerKey;
  final List<ItineraryModel> list;
  var _navigate;

  HomeWidget(this._appLocal, this._drawerKey, this.list);

  @override
  Widget build(BuildContext context) {
    _navigate = Navigator.of(context);
    return Stack(
      children: <Widget>[
        headerImage(),
        menuIcon(),
        blueLogo(),
        itinerariesText(),
        listBuilder()
      ],
    );
  }

  Widget headerImage() {
    return Image.asset(AssPath.HEADER_IMAGE);
  }

  Widget menuIcon() {
    return Positioned.directional(
      start: 1.5,
      top: 20,
      child: IconButton(
        icon: Icon(
          Icons.menu,
          size: Sizes.MENU_SIZE,
        ),
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

  Widget listBuilder() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 60, right: 60),
      child: ListView.separated(
        padding: EdgeInsets.only(top: 200),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return itineraryView(list[index]);
        },
        separatorBuilder: (context, index) {
          return Sizes.DIVIDER_HEIGHT_15;
        },
      ),
    );
  }

  Widget itineraryView(ItineraryModel model) {
    return InkWell(
      onTap: () {
        print(model.title);
        _navigate.pushNamed(ItineraryDetailsScreen.ROUTE_NAME);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_12),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: model.bgColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Sizes.RADIUS_12,
                  topEnd: Sizes.RADIUS_12,
                ),
              ),
              child: Center(
                child: Image.asset(model.imgUrl),
              ),
            ),
            Text(
              model.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              model.duration,
              style: TextStyle(fontSize: 14),
            ),
            Sizes.DIVIDER_HEIGHT_10
          ],
        ),
      ),
    );
  }
}

class ItineraryModel {
  final String title;
  final String duration;
  final String imgUrl;
  final Color bgColor;

  ItineraryModel(this.title, this.duration, this.imgUrl, this.bgColor);

  static List<ItineraryModel> getItinerariesList(AppLocalizations appLocale) {
    return [
      ItineraryModel(
          appLocale.translate(LocalKeys.NATURAL_ITINERARIES),
          appLocale.translate(LocalKeys.ABOUT_3_DAYS),
          AssPath.NATURE_LOGO,
          Coolor.NAT_ITI_COL),
      ItineraryModel(
          appLocale.translate(LocalKeys.ARCHEOLOGY_ITINERARIES),
          appLocale.translate(LocalKeys.ABOUT_4_DAYS),
          AssPath.ARCHEOLOGY_LOGO,
          Coolor.ARC_ITI_COL),
      ItineraryModel(
          appLocale.translate(LocalKeys.CLUTURE_ITINERARIES),
          appLocale.translate(LocalKeys.ABOUT_2_DAYS),
          AssPath.CULTURE_LOGO,
          Coolor.CUL_ITI_COL)
    ];
  }
}
