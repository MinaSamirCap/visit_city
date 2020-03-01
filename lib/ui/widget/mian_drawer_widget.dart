import 'package:flutter/material.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../ui/widget/ui.dart';
import '../../res/sizes.dart';

class MainDrawerWidget extends StatefulWidget {
  final Function callback;
  List<MenuModel> menuList;

  MainDrawerWidget(appLocal, this.callback) {
    menuList = MenuModel.getMenuList(appLocal);
  }

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
      itemCount: 7,
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
        return menuListItem(widget.menuList[index + 7]);
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
                    color: Coolor.MENU_SEL_COL,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Sizes.RADIUS_50,
                      topEnd: Sizes.RADIUS_50,
                    ),
                  )
                : null,
            child: ListTile(
              leading: Icon(
                model.icon,
                color: getColor(model.isSelected),
              ),
              title: Text(
                model.title,
                style: TextStyle(color: getColor(model.isSelected)),
              ),
              onTap: () {
                widget.menuList.forEach((item) {
                  item.isSelected = false;
                });
                model.isSelected = true;
                setState(() {});
                Navigator.pop(ctx);
                widget.callback(model.title);
              },
            ),
          ),
        ],
      );
    });
  }

  Color selectedColor() {
    return Coolor.GREY;
  }

  Color notSelectedColor() {
    return Coolor.BLACK;
  }

  Color getColor(bool isSelected) {
    return isSelected ? selectedColor() : notSelectedColor();
  }
}

class MenuModel {
  bool isSelected = false;
  String title;
  IconData icon;

  MenuModel({@required this.title, @required this.icon, this.isSelected});

  static List<MenuModel> getMenuList(AppLocalizations appLocale) {
    return [
      MenuModel(
          title: appLocale.translate(LocalKeys.WISHLIST),
          icon: Icons.favorite_border,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.PROFILE),
          icon: Icons.account_box,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.GUIDE_BOOK),
          icon: Icons.book,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.MIXED_ITE),
          icon: Icons.calendar_today,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.HOW_TO_USE_APP),
          icon: Icons.question_answer,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.INTRO_ABOUT_FAYOUM),
          icon: Icons.info,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.USEFUL_CONTACTS),
          icon: Icons.contacts,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.FEEDBACK),
          icon: Icons.feedback,
          isSelected: false),
      MenuModel(
          title: appLocale.translate(LocalKeys.LOGOUT),
          icon: Icons.exit_to_app,
          isSelected: false)
    ];
  }
}
