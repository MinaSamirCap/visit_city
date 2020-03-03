import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../general/general.dart';
import '../../models/explore/explore_response.dart';
import '../../ui/screens/explore_details_screen.dart';
import '../../ui/widget/explore_cell_widget.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../models/explore/explore_model.dart';
import '../../models/explore/explore_wrapper.dart';
import '../../apis/api_manager.dart';
import '../../models/category/category_wrapper.dart';
import '../../models/message_model.dart';
import '../../res/assets_path.dart';
import '../../ui/widget/ui.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import 'filter_widget.dart';

const imgeWidth = Sizes.imgeWidth;

class ExploreWidget extends StatefulWidget {
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchTextController = TextEditingController();

  double columnCellWidth = 0;

  List<FilterItem> filterList = [];
  List<ExploreModel> exploreList = [];
  List<ExploreModel> searchList = [];
  ExploreResponse _pagingInfo;

  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  bool _isLoadingNow = true;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      clearPaging();
      callCategoriesApi();
    });
    super.initState();
  }

  void resetScreen() {
    clearPaging();
    clearSearch();
  }

  void clearPaging() {
    exploreList.clear();
    _pagingInfo = ExploreResponse.clearPagin();
  }

  void clearSearch() {
    _searchTextController.text = "";
    searchList.clear();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    columnCellWidth = MediaQuery.of(context).size.width - imgeWidth - 30 - 10;
    //columnCellWidth =Sizes.calculateColumnWidth(MediaQuery.of(context).size.width);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
          bottom: FilterWidget(filterList, allIsSelected, selectedFilters),
          title: searchWidget(),
        ),
        body: pagingWidget());
  }

  Widget pagingWidget() {
    return Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (shouldLoadMore(scrollInfo)) {
                  callExploreApi();
                  setState(() {
                    _isLoadingNow = true;
                  });
                }
                return false;
              },
              child: listWidget()),
        ),
        pagingLoadingWidget(_isLoadingNow),
      ],
    );
  }

  Widget searchWidget() {
    return TextFormField(
      controller: _searchTextController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      minLines: 1,
      decoration: InputDecoration(
          icon: Icon(Icons.search),
          labelText: _appLocal.translate(LocalKeys.SEARCH)),
      onChanged: (textChanged) {
        /// filter current list according to received text.
        updateSearchList(textChanged);
      },
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
      itemCount: searchList.length,
    );
  }

  Widget exploreItemWidget(int index) {
    ExploreModel model = searchList[index];
    return Card(
        shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
        child: ClipRRect(
          borderRadius: Sizes.BOR_RAD_20,
          child: InkWell(
            onTap: () {
              /// open details screen
              Navigator.of(context).pushNamed(ExploreDetailsScreen.ROUTE_NAME,
                  arguments: {ExploreDetailsScreen.MODEL_KEY: model.toJson()});
            },
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: Sizes.BOR_RAD_20,
                  border: Border.all(color: Coolor.GREY, width: 1)),
              child: Row(
                children: <Widget>[imageWidget(model), halfExporeWidget(model)],
              ),
            ),
          ),
        ));
  }

  Widget imageWidget(ExploreModel model) {
    // I am sure it is working tested on real device ...
    // return FadeInImage.assetNetwork(
    //   placeholder: AssPath.APP_LOGO,
    //   image: model.photos.isEmpty ? "" : model.photos[0],
    //   height: double.infinity,
    //   width: imgeWidth,
    //   fit: BoxFit.cover,
    //   fadeInDuration: new Duration(milliseconds: 100),
    // );

    return exploreImgWidget(
        imgeWidth, model.photos.isEmpty ? "" : model.photos[0]);
  }

  Widget halfExporeWidget(ExploreModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
          child: Text(
            model.name,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          width: columnCellWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ratingWidget(model.rate),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                child: Text(model.reviews.toString() +
                    " " +
                    _appLocal.translate(LocalKeys.REVIEWS)),
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
                  model.price,
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
              ExploreCellWidget(
                  _appLocal.translate(LocalKeys.GO), Icons.near_me, () {
                if (model.location.isNotEmpty && model.location.length == 2) {
                  launchMap(model.location[0], model.location[1]);
                }
              }),
              ExploreCellWidget("${model.openHours.from} ${model.openHours.to}",
                  Icons.access_time, () {}),
              // removed favorite icon
              // ExploreCellWidget("", Icons.favorite_border, () {
              //
              // }),
            ],
          ),
        )
      ],
    );
  }


  

  void callCategoriesApi() async {
    _progressDialog.show();
    _apiManager.categoriesApi((CategoryWrapper wrapper) {
      _progressDialog.hide();
      setState(() {
        filterList = FilterItem.getFilterList(wrapper.data, _appLocal);
        callExploreApi();
      });
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
    });
  }

  void callExploreApi({String query = ""}) async {
    _apiManager.exploreApi(_pagingInfo.page + 1, query,
        (ExploreWrapper wrapper) {
      setState(() {
        exploreList.addAll(wrapper.data.docs);
        adjustSearchList();
        _pagingInfo = wrapper.data;
        _isLoadingNow = false;
        if (!_pagingInfo.hasNextPage) {
          showSnackBar(
              createSnackBar(_appLocal.translate(LocalKeys.NO_MORE_DATA)),
              _scaffoldKey);
        }
      });
    }, (MessageModel messageModel) {
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  void allIsSelected() {
    resetScreen();
    callExploreApi();
  }

  void selectedFilters(List<FilterItem> list) {
    resetScreen();
    List ids = list.map((item) => item.category.id.toString()).toList();
    callExploreApi(query: ids.join(","));
  }

  bool shouldLoadMore(ScrollNotification scrollInfo) {
    return (!_isLoadingNow &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        _pagingInfo.hasNextPage);
  }

  void adjustSearchList() {
    clearSearch();
    searchList.addAll(exploreList);
  }

  void updateSearchList(String changedText) {
    setState(() {
      searchList = exploreList
          .where((element) =>
              (element.name.toLowerCase().contains(changedText.toLowerCase())))
          .toList();
    });
  }
}
