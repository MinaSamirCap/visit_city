import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../models/rate/rate_model.dart';
import '../../models/rate/rate_post_wrapper.dart';
import '../../models/rate/rate_response.dart';
import '../../models/rate/rate_send_model.dart';
import '../../models/rate/rate_wrapper.dart';
import '../../prefs/pref_manager.dart';
import '../../ui/base/base_state.dart';
import '../../models/wishlist/like_dislike_wrapper.dart';
import '../../models/wishlist/wishlist_send_model.dart';
import '../../res/coolor.dart';
import '../../ui/widget/carousel_with_indicator_widget.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../ui/widget/silver_app_bar_delegation.dart';
import '../../res/sizes.dart';
import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/sight/sight_response.dart';
import '../../models/sight/sight_wrapper.dart';
import '../../ui/widget/ui.dart';
import '../../utils/lang/app_localization.dart';

class SightDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/sight-details';
  static const MODEL_ID_KEY = 'sight_id';

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen>
    with BaseState {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;

  String sightId = "";
  SightResponse sightModel;
  List<RateModel> rateList = [];
  RateResponse _pagingInfo;
  int _currentTab = 0;
  double initRate = 0.0;
  bool firstTimeToLoad = true;
  bool _isLoadingNow = true;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      clearPaging();
      callDetailsApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    sightId = args[SightDetailsScreen.MODEL_ID_KEY];

    _appLocal = AppLocalizations.of(context);

    return Scaffold(
        key: _scaffoldKey,
        body: DefaultTabController(length: 3, child: pagingWidget()));
  }

  Widget nestedScrollingWidget() {
    return Expanded(
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: Sizes.hightDetails,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(getTitle()),
                  background: getPhotosOrDummyWidget()),
            ),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                TabBar(
                  indicator: getTabIndicator(),
                  labelColor: Coolor.BLACK,
                  unselectedLabelColor: Coolor.GREY,
                  tabs: [
                    Tab(text: _appLocal.translate(LocalKeys.OVERVIEW)),
                    Tab(text: _appLocal.translate(LocalKeys.REVIEWS)),
                    Tab(text: _appLocal.translate(LocalKeys.SERVICES)),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentTab = index;
                    });
                  },
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: sightModel != null ? bodyWidget() : getCenterCircularProgress(),
      ),
    );
  }

  Widget bodyWidget() {
    if (_currentTab == 0) {
      return overviewWidget(
          _appLocal,
          sightModel.rate,
          sightModel.location,
          sightModel.desc,
          sightModel.openHours,
          sightModel.price,
          sightModel.contact,
          sightModel.website);
    } else if (_currentTab == 1) {
      return reviewWidget();
    } else {
      return servicesWidget();
    }
  }

  Widget reviewWidget() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: Sizes.EDEGINSETS_20,
      child: Column(
        children: <Widget>[
          postReviewRowWidget(
              _appLocal,
              (value) {
                setState(() {
                  initRate = value;
                });
              },
              initRate,
              () {
                postClicked();
              }),
          Sizes.DIVIDER_HEIGHT_10,
          postReviewWidget(_appLocal, _textController, null),
          if (firstTimeToLoad)
            ...{Sizes.DIVIDER_HEIGHT_60, getCenterCircularProgress()}.toList(),
          getReviewList()
        ],
      ),
    );
  }

  Widget servicesWidget() {
    return new GridView.builder(
        itemCount: sightModel.categories.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Image.network(
                sightModel.categories[index].logo,
                height: 90,
              ),
              Text(sightModel.categories[index].name)
            ],
          );
        });
  }

  Widget favIcon() {
    return InkWell(
      child: Padding(
        padding: Sizes.EDEGINSETS_15,
        child: Icon(
          sightModel != null
              ? sightModel.like ? Icons.favorite : Icons.favorite_border
              : Icons.favorite_border,
          color: Coolor.RED,
        ),
      ),
      onTap: () {
        callLikeDislikeApi();
      },
    );
  }

  Widget pagingWidget() {
    return Column(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (shouldLoadMore(scrollInfo)) {
                callReviewApi();
                setState(() {
                  _isLoadingNow = true;
                });
              }
              return false;
            },
            child: nestedScrollingWidget()),
        pagingLoadingWidget(_isLoadingNow && !firstTimeToLoad),
      ],
    );
  }

  Widget getReviewList() {
    return ListView.separated(
        controller: _scrollController,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          RateModel model = rateList[index];
          return userReview(
              model.user.photo, model.user.name, model.rate, model.comment);
        },
        separatorBuilder: (ctx, index) {
          return getReviewSeparator();
        },
        itemCount: rateList.length);
  }

  Widget getPhotosOrDummyWidget() {
    if (sightModel == null) {
      return getCenterCircularProgress();
    }
    if (sightModel.photos.length > 0) {
      return CarouselWithIndicator(sightModel.photos);
    } else {
      return Center(
        child: getNotPicWidget(_appLocal),
      );
    }
  }

  void postClicked() async {
    final isGuest = await PrefManager.isGuest();
    if (isGuest) {
      showSnackBar(createSnackBar(_appLocal.translate(LocalKeys.GUEST_RATE)),
          _scaffoldKey);
    } else {
      if (initRate == 0.0) {
        showSnackBar(createSnackBar(_appLocal.translate(LocalKeys.RATE_ERROR)),
            _scaffoldKey);
      } else {
        /// call api .. :)
        callRateSightApi();
      }
    }
  }

  void callDetailsApi() async {
    _progressDialog.show();
    _apiManager.getSightDetails(sightId, (SightWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        sightModel = wrapper.data;
      });
      callReviewApi();
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
      });
    });
  }

  void callLikeDislikeApi() async {
    _progressDialog.show();
    _apiManager.likeDislikeApi(WishlistSendModel([sightModel.id]),
        (LikeDislikeWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        sightModel.like = !sightModel.like;
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

  void callReviewApi() async {
    _apiManager.sightsReviewApi(_pagingInfo.page + 1, sightModel.id,
        (RateWrapper wrapper) {
      setState(() {
        firstTimeToLoad = false;
        _isLoadingNow = false;
        rateList.addAll(wrapper.data.docs);
        _pagingInfo = wrapper.data;
        if (!_pagingInfo.hasNextPage) {
          showSnackBar(
              createSnackBar(_appLocal.translate(LocalKeys.NO_MORE_DATA)),
              _scaffoldKey);
        }
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        firstTimeToLoad = false;
        _isLoadingNow = false;
      });
    });
  }

  void callRateSightApi() async {
    _progressDialog.show();
    final userModel = await PrefManager.getUser();
    _apiManager.submitSightsReview(
        RateSendModel(initRate.toInt(), _textController.text), sightModel.id,
        (RatePostWrapper wrapper) {
      setState(() {
        rateList.insert(
            0,
            RateModel.quickRate(userModel.name, userModel.photo, initRate,
                _textController.text));
        _progressDialog.hide();
        resetRate();
        showSnackBar(createSnackBar(wrapper.message.message), _scaffoldKey);
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _progressDialog.hide();
      });
    });
  }

  String getTitle() {
    if (sightModel != null) {
      return sightModel.name;
    } else {
      return "";
    }
  }

  bool shouldLoadMore(ScrollNotification scrollInfo) {
    return (_currentTab == 1 &&
        !_isLoadingNow &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        _pagingInfo.hasNextPage);
  }

  void clearPaging() {
    rateList.clear();
    _pagingInfo = RateResponse.clearPagin();
  }

  void resetRate() {
    initRate = 0.0;
    _textController.text = "";
  }

  @override
  BuildContext provideContext() {
    return context;
  }
}
