import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
            "http://www.travelstart.com.eg/blog/wp-content/uploads/2014/09/1891075_669849953073194_879316005_n.jpg"),
        Positioned.directional(
          start: 3,
          top: 15,
          child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ), textDirection: TextDirection.ltr,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(240);
}
