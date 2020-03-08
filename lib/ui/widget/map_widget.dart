import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

enum ImageFilter {
  all,
  natural,
  archeology,
  culture,
}

class MapWidget extends StatefulWidget {
  static final ROUTE_NAME = '/maps-widget';
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  AppLocalizations _appLocal;

  ImageFilter _imageFilter = ImageFilter.all;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.MAP)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          mapFiltersWidget(),
          Sizes.DIVIDER_HEIGHT_100,
          mapImageWidget(),
        ],
      ),
    );
  }

  Widget mapImageWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PhotoView(
        imageProvider: getImage(_imageFilter),
        // enableRotation: true,
        // Contained = the smallest possible size to fit one dimension of the screen
        minScale: PhotoViewComputedScale.contained * 0.8,
        // Covered = the smallest possible size to fit the whole screen
        maxScale: PhotoViewComputedScale.covered * 2,
        backgroundDecoration: BoxDecoration(
          color: Coolor.FEEDBACK_OFF_WHITE,
        ),
        loadingChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  AssetImage getImage(ImageFilter filter) {
    switch (filter) {
      case ImageFilter.all:
        return AssetImage(AssPath.MAP_FULL);
      case ImageFilter.natural:
        return AssetImage(AssPath.NATURE_MAP);
      case ImageFilter.archeology:
        return AssetImage(AssPath.ARCH_MAP);
      case ImageFilter.culture:
        return AssetImage(AssPath.CULTURE_MAP);

      default: return AssetImage(AssPath.MAP_FULL);
    }
    
  }

  Widget mapFiltersWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            setState(() {
              _imageFilter = ImageFilter.all;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.FEEDBACK_OFF_WHITE,
          child: Text(_appLocal.translate(LocalKeys.ALL)),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              _imageFilter = ImageFilter.natural;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.NAT_ITI_COL,
          child: Text(_appLocal.translate(LocalKeys.NATURE)),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              _imageFilter = ImageFilter.archeology;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
            side: BorderSide(color: Coolor.GREY),
          ),
          elevation: 5,
          color: Coolor.ARC_ITI_COL,
          child: Text(_appLocal.translate(LocalKeys.ARCHEOLOGY)),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              _imageFilter = ImageFilter.culture;
            });
          },
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
