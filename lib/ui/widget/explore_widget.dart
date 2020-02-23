import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../apis/api_manager.dart';
import '../../models/category/category_wrapper.dart';
import '../../models/message_model.dart';
import '../../res/assets_path.dart';
import '../../ui/widget/ui.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  double columnCellWidth = 0;
  ProgressDialog progressDialog;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callCategoriesApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    progressDialog = getPlzWaitProgress(context, _appLocal);
    columnCellWidth = MediaQuery.of(context).size.width - imgeWidth - 30 - 10;
    print("Width ${MediaQuery.of(context).size.width}");
    print("ColumnWidth $columnCellWidth");

    return Scaffold(
        key: _scaffoldKey,
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
    // I am sure it is working tested on real device ...
    return FadeInImage.assetNetwork(
      placeholder: AssPath.APP_LOGO,
      image:
          "https://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/acropolis-athens-medium.jpg",
      height: double.infinity,
      width: imgeWidth,
      fit: BoxFit.cover,
      fadeInDuration: new Duration(milliseconds: 100),
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
                  InkWell(
                    child: Icon(Icons.navigation),
                    onTap: () {
                      print("go clicked");
                    },
                  ),
                  Text("Go", style: actionStyleItem())
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.access_time),
                  Text("Closed", style: actionStyleItem())
                ],
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.favorite_border),
                    onTap: () {
                      print("favorite clicked");
                    },
                  ),
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

  Future<void> callCategoriesApi() async {
    progressDialog.show();
    await Provider.of<ApiManager>(context, listen: false).categoriesApi(
        (CategoryWrapper wrapper) {
      progressDialog.hide();
      
    }, (MessageModel messageModel) {
      progressDialog.hide();
      showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
    });
  }
}
