import 'package:flutter/material.dart';

class Sizes {
  static const paddingColumn = -30 - 10;
  static const imgeWidth =
      110.0; // image width of explore item and wishlist item
  static double calculateColumnWidth(double screenWidth) {
    return screenWidth - imgeWidth - paddingColumn;
  }

  static const RADIUS_500 = Radius.circular(500);
  static const RADIUS_25 = Radius.circular(25);
  static const RADIUS_50 = Radius.circular(50);
  static const RADIUS_12 = Radius.circular(12);

  static const DIVIDER_HEIGHT_3 = SizedBox(
    height: 3,
  );

  static const DIVIDER_HEIGHT_10 = SizedBox(
    height: 10,
  );

  static const DIVIDER_HEIGHT_15 = SizedBox(
    height: 15,
  );

  static const DIVIDER_HEIGHT_30 = SizedBox(
    height: 30,
  );
  static const DIVIDER_HEIGHT_60 = SizedBox(
    height: 60,
  );
  static const DIVIDER_HEIGHT_100 = SizedBox(
    height: 100,
  );
  static const DIVIDER_HEIGHT_130 = SizedBox(
    height: 130,
  );
  static const DIVIDER_HEIGHT_150 = SizedBox(
    height: 150,
  );

  static const DIVIDER_HEIGHT_200 = SizedBox(
    height: 200,
  );

  static const DIVIDER_WIDTH_0 = SizedBox(
    width: 0,
  );
  static const DIVIDER_WIDTH_5 = SizedBox(
    width: 5,
  );

  static const DIVIDER_WIDTH_10 = SizedBox(
    width: 10,
  );

  static const DIVIDER_WIDTH_15 = SizedBox(
    width: 15,
  );
  static const DIVIDER_WIDTH_20 = SizedBox(
    width: 20,
  );
  static const DIVIDER_WIDTH_50 = SizedBox(
    width: 50,
  );

  static final BOR_RAD_35 = BorderRadius.circular(35);
  static final BOR_RAD_25 = BorderRadius.circular(25);
  static final BOR_RAD_20 = BorderRadius.circular(20);
  static final BOR_RAD_18 = BorderRadius.circular(18);
  static final BOR_RAD_15 = BorderRadius.circular(15);
  static final BOR_RAD_17 = BorderRadius.circular(17);
  static final BOR_RAD_12 = BorderRadius.circular(12);
  static final BOR_RAD_7 = BorderRadius.circular(7);

  static const EDEGINSETS_0 = EdgeInsets.all(0.0);
  static const EDEGINSETS_4 = EdgeInsets.all(4.0);
  static const EDEGINSETS_5 = EdgeInsets.all(5.0);
  static const EDEGINSETS_8 = EdgeInsets.all(8.0);
  static const EDEGINSETS_10 = EdgeInsets.all(10.0);
  static const EDEGINSETS_15 = EdgeInsets.all(15.0);
  static const EDEGINSETS_20 = EdgeInsets.all(20.0);
  static const EDEGINSETS_25 = EdgeInsets.all(25.0);
  static const EDEGINSETS_30 = EdgeInsets.all(30.0);
  static const EDEGINSETS_35 = EdgeInsets.all(35.0);

  static const SIZE_3_3 = 3.3;
  static const SIZE_10 = 10.0;
  static const SIZE_18 = 18.0;
  static const SIZE_20 = 20.0;
  static const SIZE_25 = 25.0;
  static const SIZE_30 = 30.0;
  static const SIZE_35 = 35.0;
  static const SIZE_50 = 50.0;
  static const SIZE_60 = 60.0;
  static const SIZE_75 = 75.0;
  static const SIZE_100 = 100.0;
  static const SIZE_120 = 120.0;
  static const SIZE_150 = 150.0;
  static const SIZE_300 = 300.0;

  static const MENU_SIZE = SIZE_35;
}
