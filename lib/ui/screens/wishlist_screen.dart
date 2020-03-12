import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/ui/base/base_state.dart';
import '../../ui/screens/sight_details_screen.dart';
import '../../models/wishlist/like_dislike_wrapper.dart';
import '../../general/url_launchers.dart';
import '../../models/wishlist/wishlist_send_model.dart';
import '../../res/coolor.dart';
import '../../ui/widget/explore_cell_widget.dart';
import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/wishlist/wishlist_model.dart';
import '../../models/wishlist/wishlist_response.dart';
import '../../models/wishlist/wishlist_wrapper.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

const imgeWidth = Sizes.imgeWidth;

class WishlistScreen extends StatefulWidget {
  static const ROUTE_NAME = '/wishlist';

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> with BaseState {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double cellHight = 0;
  double columnCellWidth = 0;

  List<WishlistModel> wishlistList = [];
  WishlistResponse _pagingInfo;
  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  bool _isLoadingNow = true;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      _progressDialog.show();
      clearPaging();
      callWishlistApi();
    });
    super.initState();
  }

  void clearPaging() {
    wishlistList.clear();
    _pagingInfo = WishlistResponse.clearPagin();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    cellHight = Sizes.calculateExploreCellHight(_appLocal.isRTL());
    columnCellWidth =
        Sizes.calculateColumnWidth(MediaQuery.of(context).size.width);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.WISHLIST)),
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
                  callWishlistApi();
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

  Widget listWidget() {
    return ListView.separated(
      padding: Sizes.EDEGINSETS_15,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        return exploreItemWidget(index);
      },
      itemCount: wishlistList.length,
    );
  }

  Widget exploreItemWidget(int index) {
    WishlistModel model = wishlistList[index];
    return Card(
        shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
        child: ClipRRect(
          borderRadius: Sizes.BOR_RAD_20,
          child: InkWell(
            onTap: () {
              /// open details screen
              openDetialsSightScreen(index);
            },
            child: Container(
              height: cellHight,
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

  Widget imageWidget(WishlistModel model) {
    return exploreImgWidget(
        imgeWidth, model.photos.isEmpty ? "" : model.photos[0]);
  }

  Widget halfExporeWidget(WishlistModel model) {
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
              ExploreCellWidget(
                "",
                model.like ? Icons.favorite : Icons.favorite_border,
                () {
                  likeDislikeClicked(model);
                },
                iconColor: Coolor.RED,
              ),
            ],
          ),
        )
      ],
    );
  }

  bool shouldLoadMore(ScrollNotification scrollInfo) {
    return (!_isLoadingNow &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        _pagingInfo.hasNextPage);
  }

  void openDetialsSightScreen(int index) {
    Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,
        arguments: {SightDetailsScreen.MODEL_ID_KEY: wishlistList[index].id.toString()});
  }

  void likeDislikeClicked(WishlistModel model) {
    callLikeDislikeApi(model, true);
  }

  void callWishlistApi() async {
    _apiManager.wishlistApi(_pagingInfo.page + 1, (WishlistWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        wishlistList.addAll(wrapper.data.docs);
        _pagingInfo = wrapper.data;
        _isLoadingNow = false;
        if (!_pagingInfo.hasNextPage) {
          showSnackBar(
              createSnackBar(_appLocal.translate(LocalKeys.NO_MORE_DATA)),
              _scaffoldKey);
        }
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  void callLikeDislikeApi(WishlistModel model, bool isLiked) async {
    _progressDialog.show();
    _apiManager.likeDislikeApi(WishlistSendModel([model.id]),
        (LikeDislikeWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        wishlistList.remove(model);
        showSnackBar(createSnackBar(wrapper.message.message), _scaffoldKey);
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
      });
    });
  }

  @override
  BuildContext provideContext() {
    return context;
  }
}
