import 'package:flutter/material.dart';
import 'package:visit_city/ui/widget/ui.dart';
import '../../res/sizes.dart';

class MainDrawerWidget extends StatefulWidget {
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
            Sizes.DIVIDER_HEIGHT_60,
            lineDivider(),
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
      width: double.infinity,
      height: 150,
      child: Center(
        child: Image.network(
            "https://i.ebayimg.com/images/g/oVAAAOSwinVZtNGR/s-l300.jpg"),
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget feedbackLogoutListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
        );
      },
    );
  }
}
