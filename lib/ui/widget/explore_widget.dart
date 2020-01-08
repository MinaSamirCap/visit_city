import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:visit_city/ui/widget/ui.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import 'filter_widget.dart';

const imgeWidth = 110.0;

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  AppLocalizations _appLocal;
  double columnCellWidth = 0;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    columnCellWidth = MediaQuery.of(context).size.width - imgeWidth - 30 - 10;
    print("Width ${MediaQuery.of(context).size.width}");
    print("ColumnWidth $columnCellWidth");
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
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: Sizes.BOR_RAD_20,
                  border: Border.all(color: Coolor.GREY, width: 1)),
              child: Row(
                children: <Widget>[imageWidget(), halfExporeWidget()],
              ),
            ),
          ),
        ));
  }

  Widget imageWidget() {
    return Image.network(
      "https://indiabests.com/wp-content/uploads/2019/09/khajrho-1230x692.jpg",
      width: imgeWidth,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget halfExporeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
          child: Text(
            "Mina",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          width: columnCellWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ratingWidget(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                child: Text("5 reviews"),
              ),
            ],
          ),
        ),
        Sizes.DIVIDER_HEIGHT_10,
        Container(
          width: columnCellWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                child: Text(
                  "@@##%",
                  style: TextStyle(color: Coolor.BLUE_APP),
                ),
              )
            ],
          ),
        ),
        Sizes.DIVIDER_HEIGHT_10,
        lineDividerWidth(columnCellWidth),
        Sizes.DIVIDER_HEIGHT_10,
        Container(
          width: columnCellWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.navigation),
                  Text("go", style: actionStyleItem())
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.access_time),
                  Text("closed", style: actionStyleItem())
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  Text("", style: actionStyleItem())
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget ratingWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
      child: RatingBarIndicator(
        rating: 3.25,
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
    );
  }

  TextStyle actionStyleItem() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  }
}
