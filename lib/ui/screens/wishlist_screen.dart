import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/wishlist/wishlist_model.dart';
import '../../models/wishlist/wishlist_response.dart';
import '../../models/wishlist/wishlist_wrapper.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class WishlistScreen extends StatefulWidget {
  static const ROUTE_NAME = '/wishlist';

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      clearPaging();
      _progressDialog.show();
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
        return /*exploreItemWidget(index)*/ Text("Item$index");
      },
      itemCount: wishlistList.length,
    );
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
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  bool shouldLoadMore(ScrollNotification scrollInfo) {
    return (!_isLoadingNow &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        _pagingInfo.hasNextPage);
  }
}
