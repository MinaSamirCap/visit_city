import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class MapWidget extends StatelessWidget {
  AppLocalizations _appLocal;
  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Map'),
      ),
      body: Column(
        children: <Widget>[
          
          mapFiltersWidget(),
          // Sizes.DIVIDER_HEIGHT_150,
          mapImageWidget(),
        ],
      ),
    );
  }
  Widget mapImageWidget() {
    return Center(
        child: PhotoView(
          imageProvider: AssetImage(AssPath.MAP_FULL),
          tightMode: true,
          maxScale: double.infinity,

        ),
      );
  }
  Widget mapFiltersWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.NAT_ITI_COL,
          child: Text(_appLocal.translate(LocalKeys.NATURE)),
        ),
        RaisedButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.ARC_ITI_COL,
          child: Text(_appLocal.translate(LocalKeys.ARCHEOLOGY)),
        ),
        RaisedButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.CUL_ITI_COL,
          child: Text(_appLocal.translate(LocalKeys.CULTURE)),
        ),
      ],
    );
  }
}