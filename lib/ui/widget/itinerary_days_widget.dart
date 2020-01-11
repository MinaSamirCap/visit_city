import 'package:flutter/material.dart';
import 'package:visit_city/utils/lang/app_localization.dart';
import 'package:visit_city/utils/lang/app_localization_keys.dart';

import '../../res/coolor.dart';
import '../../res/sizes.dart';

class ItineraryDaysWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final List<DayItem> _daysList;

  ItineraryDaysWidget(this._daysList);
  @override
  _ItineraryDaysWidgetState createState() => _ItineraryDaysWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _ItineraryDaysWidgetState extends State<ItineraryDaysWidget> {
  AppLocalizations _appLocal;
  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Column(
      children: <Widget>[
        daysListWidget(),
        Sizes.DIVIDER_HEIGHT_10,
      ],
    );
  }

  Widget daysListWidget() {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget._daysList.length,
          itemBuilder: (ctx, index) {
            return daysItemWidget(widget._daysList[index]);
          },
          separatorBuilder: (_, __) {
            return Sizes.DIVIDER_WIDTH_10;
          },
        ),
      ),
    );
  }

  Widget daysItemWidget(DayItem item) {
    return Column(
      children: <Widget>[
        Text(
          _appLocal.translate(LocalKeys.DAY),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Coolor.GREY_DARK,
          ),
        ),
        RaisedButton(
          onPressed: () {
            if (widget._daysList[0].title == item.title && !item.isSelected) {
              widget._daysList.forEach((item) {
                item.isSelected = false;
              });
            }
            item.isSelected = !item.isSelected;
            setState(() {});
            print(item.title);
            selectedItem(item);
          },
          shape: CircleBorder(
              side: item.isSelected
                  ? BorderSide(color: Coolor.FEEDBACK_OFF_WHITE)
                  : BorderSide(color: Coolor.GREY)),
          color: item.isSelected ? Coolor.BLUE_APP : Coolor.FEEDBACK_OFF_WHITE,
          textColor: item.isSelected ? Coolor.WHITE : Coolor.GREY,
          child: Text(item.title),
        ),
      ],
    );
  }

  void selectedItem(DayItem item) {
    //// you can call api here or outside.
  }
}

class DayItem {
  bool isSelected = false;
  String title;

  DayItem({@required this.title, this.isSelected});

  static List<DayItem> getDaysList(AppLocalizations appLocale) {
    return [
      DayItem(title: appLocale.translate(LocalKeys.ONE), isSelected: true),
      DayItem(title: appLocale.translate(LocalKeys.TWO), isSelected: false),
      DayItem(title: appLocale.translate(LocalKeys.THREE), isSelected: false),
    ];
  }
}
