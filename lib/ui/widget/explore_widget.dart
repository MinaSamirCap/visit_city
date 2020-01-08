import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:visit_city/ui/widget/ui.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

import 'filter_widget.dart';

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  AppLocalizations _appLocal;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
          bottom: FilterWidget(FilterItem.getFilterList(_appLocal)),
          title: searchWidget(),
        ),
        body: listWidget());
  }

  Widget searchWidget() {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: 1,
      minLines: 1,
      decoration:
          InputDecoration(icon: Icon(Icons.search), labelText: "search"),
    );
  }

  Widget listWidget() {
    return ListView.separated(
      padding: Sizes.EDEGINSETS_15,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        return exploreItemWidget(index);
      },
      itemCount: 18,
    );
  }

  Widget exploreItemWidget(int index) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
        child: ClipRRect(
          borderRadius: Sizes.BOR_RAD_20,
          child: InkWell(
            onTap: () {
              print("object$index");
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: Sizes.BOR_RAD_20,
                  border: Border.all(color: Coolor.GREY, width: 1)),
              child: Row(
                children: <Widget>[
                  Image.network(
                    "https://indiabests.com/wp-content/uploads/2019/09/khajrho-1230x692.jpg",
                    width: 100,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                        child: Text(
                          "Mina",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 5, 0, 0),
                              child: RatingBarIndicator(
                                rating: 4.5,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding: EdgeInsets.all(0),
                                itemBuilder: (ctx, index) {
                                  return Icon(
                                    Icons.star,
                                    color: Coolor.BLUE_APP,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text("5 reviews"),
                            ),
                          ],
                        ),
                      ),
                      Text("!!@@##"),
                      Container(color: Coolor.GREY, width: 250, height: 2,),
                      Row(children: <Widget>[
                          Column(children: <Widget>[
                            Icon(Icons.navigation),
                            Text("go")
                          ],),
                           Column(children: <Widget>[
                            Icon(Icons.navigation),
                            Text("go")
                          ],),
                           Column(children: <Widget>[
                            Icon(Icons.navigation),
                            Text("go")
                          ],)
                      ],)
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
