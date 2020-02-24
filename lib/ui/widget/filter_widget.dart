import 'package:flutter/material.dart';
import 'package:visit_city/utils/lang/app_localization.dart';
import '../../models/category/category_response.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';

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
          if (widget._filterList[0].category.name == item.category.name &&
              !item.isSelected) {
            widget._filterList.forEach((item) {
              item.isSelected = false;
            });
          }
          item.isSelected = !item.isSelected;
          setState(() {});
          selectedItem(item);
        },
        shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_18,
            side: item.isSelected
                ? BorderSide(color: Coolor.FEEDBACK_OFF_WHITE)
                : BorderSide(color: Coolor.GREY)),
        color: item.isSelected ? Coolor.BLUE_APP : Coolor.FEEDBACK_OFF_WHITE,
        textColor: item.isSelected ? Coolor.WHITE : Coolor.GREY,
        child: Text(item.category.name));
  }

  void selectedItem(FilterItem item) {
    //// you can call api here or outside.
  }
}

class FilterItem {
  bool isSelected = false;
  CategoryResponse category;

  FilterItem({@required this.category, this.isSelected});

  static List<FilterItem> getFilterList(
      List<CategoryResponse> list, AppLocalizations appLocal) {
    List<FilterItem> filterList = list.map((item) {
      return FilterItem(category: item, isSelected: false);
    }).toList();
    filterList.insert(0, getAllFilterItem(appLocal));
    return filterList;
  }

  static FilterItem getAllFilterItem(AppLocalizations appLocal) {
    return FilterItem(
        category: CategoryResponse.getAllNameCategory(appLocal),
        isSelected: true);
  }
}
