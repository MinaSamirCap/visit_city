import 'package:flutter/material.dart';
import 'package:visit_city/res/assets_path.dart';
import 'package:visit_city/ui/widget/ui.dart';
import '../../res/sizes.dart';

class MainDrawerWidget extends StatefulWidget {
  final Function callback;
  final menuList = MenuModel.getMenuList();

  MainDrawerWidget(this.callback);

  @override
  _MainDrawerWidgetState createState() => _MainDrawerWidgetState();
}

class _MainDrawerWidgetState extends State<MainDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Sizes.DIVIDER_HEIGHT_30,
            mainImage(),
            Sizes.DIVIDER_HEIGHT_10,
            MediaQuery.removePadding(
              removeTop: true,
              child: listView(),
              context: context,
            ),
            Sizes.DIVIDER_HEIGHT_100,
            lineDivider(),
            Sizes.DIVIDER_HEIGHT_10,
            MediaQuery.removePadding(
              removeTop: true,
              child: feedbackLogoutListView(),
              context: context,
            ),
          ],
        ));
  }

  Widget mainImage() {
    return Container(
      width: 200,
      height: 150,
      child: Center(
        child: Image.asset(AssPath.LOGO_BLUE),
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return menuListItem(widget.menuList[index]);
      },
    );
  }

  Widget feedbackLogoutListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return menuListItem(widget.menuList[index + 2]);
      },
    );
  }

  Widget menuListItem(MenuModel model) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Row(
        children: <Widget>[
          Container(
            width: constrains.constrainWidth() - 50,
            decoration: model.isSelected
                ? BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Sizes.RADIUS_50,
                      topEnd: Sizes.RADIUS_50,
                    ),
                  )
                : null,
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: Text(model.title),
              onTap: () {
                widget.menuList.forEach((item) {
                  item.isSelected = false;
                });
                model.isSelected = true;
                widget.callback(model.title);
                setState(() {});
                Navigator.pop(ctx);
              },
            ),
          ),
        ],
      );
    });
  }
}

class MenuModel {
  bool isSelected = false;
  String title;

  MenuModel({@required this.title, this.isSelected});

  static List<MenuModel> getMenuList() {
    return [
      MenuModel(title: "item1", isSelected: false),
      MenuModel(title: "item2", isSelected: false),
      MenuModel(title: "item3", isSelected: false),
      MenuModel(title: "item4", isSelected: false)
    ];
  }
}
