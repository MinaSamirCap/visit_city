import 'package:flutter/material.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

class FilterWidget extends StatefulWidget implements PreferredSizeWidget {
  final List<FilterItem> _filterList;

  FilterWidget(this._filterList);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[filterListWidget(), Sizes.DIVIDER_HEIGHT_10],
    );
  }

  Widget filterListWidget() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget._filterList.length,
          itemBuilder: (ctx, index) {
            return filterItemWidget(widget._filterList[index]);
          },
          separatorBuilder: (_, __) {
            return Sizes.DIVIDER_WIDTH_10;
          },
        ),
      ),
    );
  }

  Widget filterItemWidget(FilterItem item) {
    return RaisedButton(
        onPressed: () {
          if (widget._filterList[0].title == item.title && !item.isSelected) {
            widget._filterList.forEach((item) {
              item.isSelected = false;
            });
          }
          item.isSelected = !item.isSelected;
          setState(() {});
          print(item.title);
          selectedItem(item);
        },
        shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_18,
            side: item.isSelected
                ? BorderSide(color: Coolor.FEEDBACK_OFF_WHITE)
                : BorderSide(color: Coolor.GREY)),
        color: item.isSelected ? Coolor.BLUE_APP : Coolor.FEEDBACK_OFF_WHITE,
        textColor: item.isSelected ? Coolor.WHITE : Coolor.GREY,
        child: Text(item.title));
  }

  void selectedItem(FilterItem item) {
    //// you can call api here or outside.
  }
}

class FilterItem {
  bool isSelected = false;
  String title;

  FilterItem({@required this.title, this.isSelected});

  static List<FilterItem> getFilterList(AppLocalizations appLocale) {
    return [
      FilterItem(
          title: appLocale.translate(LocalKeys.WISHLIST), isSelected: true),
      FilterItem(
          title: appLocale.translate(LocalKeys.PROFILE), isSelected: false),
      FilterItem(
          title: appLocale.translate(LocalKeys.FEEDBACK), isSelected: false),
      FilterItem(
          title: appLocale.translate(LocalKeys.LOGOUT), isSelected: false),
      FilterItem(
          title: appLocale.translate(LocalKeys.LOGOUT), isSelected: false),
      FilterItem(
          title: appLocale.translate(LocalKeys.LOGOUT), isSelected: false),
      FilterItem(
          title: appLocale.translate(LocalKeys.LOGOUT), isSelected: false),
    ];
  }
}
