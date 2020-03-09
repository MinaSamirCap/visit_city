import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../models/rate/rate_post_wrapper.dart';
import '../../models/rate/rate_send_model.dart';
import '../../models/rate/rate_wrapper.dart';
import '../../models/rate/rate_model.dart';
import '../../models/rate/rate_response.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../ui/widget/carousel_with_indicator_widget.dart';
import '../../ui/widget/silver_app_bar_delegation.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../apis/api_manager.dart';
import '../../models/explore/explore_model.dart';
import '../../models/explore/service_wrapper.dart';
import '../../models/message_model.dart';
import '../../ui/widget/ui.dart';
import '../../utils/lang/app_localization.dart';

class ExploreDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/explore-details';
  static const MODEL_KEY = 'explore_model';

  @override
  _ExploreDetailsScreenState createState() => _ExploreDetailsScreenState();
}

class _ExploreDetailsScreenState extends State<ExploreDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;

  ExploreModel serviceModel;
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
    serviceModel =
        ExploreModel.fromJson(args[ExploreDetailsScreen.MODEL_KEY] as Map);
    _appLocal = AppLocalizations.of(context);

    return Scaffold(
        key: _scaffoldKey,
        body: DefaultTabController(length: 2, child: pagingWidget()));
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
                  title: Text(getTitle(serviceModel.name)),
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
        body: serviceModel != null ? bodyWidget() : getCenterCircularProgress(),
      ),
    );
  }

  Widget bodyWidget() {
    if (_currentTab == 0) {
      return overviewWidget(
          _appLocal,
          serviceModel.rate,
          serviceModel.location,
          serviceModel.desc,
          serviceModel.openHours,
          serviceModel.price,
          null,
          null);
    } else {
      return reviewWidget();
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
    if (serviceModel.photos.length > 0) {
      return CarouselWithIndicator(serviceModel.photos);
    } else {
      return Center(
        child: getNotPicWidget(_appLocal),
      );
    }
  }

  void postClicked() {
    if (initRate == 0.0) {
      showSnackBar(createSnackBar(_appLocal.translate(LocalKeys.RATE_ERROR)),
          _scaffoldKey);
    } else {
      /// call api .. :)
      callRateServiceApi();
    }
  }

  void callDetailsApi() async {
    _progressDialog.show();
    _apiManager.getExploreDetails(serviceModel.id, (ServiceWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        serviceModel = wrapper.data;
      });
      callReviewApi();
    }, (MessageModel messageModel) {
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
      });
    });
  }

  void callReviewApi() async {
    _apiManager.servicesReviewApi(_pagingInfo.page + 1, serviceModel.id,
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
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        firstTimeToLoad = false;
        _isLoadingNow = false;
      });
    });
  }

  void callRateServiceApi() async {
    _progressDialog.show();
    _apiManager.submitServiceReview(
        RateSendModel(initRate.toInt(), _textController.text), serviceModel.id,
        (RatePostWrapper wrapper) {
      setState(() {
        rateList.insert(
            0,

            /// we need to replace this model with the real data of user ..
            RateModel.quickRate(
                "Mina Samir",
                "https://wuzzuf.s3.eu-west-1.amazonaws.com/files/upload_pic/thumb_444dd8d21eeed67339226f2919ec3246.jpg",
                initRate,
                _textController.text));
        _progressDialog.hide();
        resetRate();
        showSnackBar(createSnackBar(wrapper.message.message), _scaffoldKey);
      });
    }, (MessageModel messageModel) {
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _progressDialog.hide();
      });
    });
  }

  String getTitle(String title) {
    if (serviceModel != null) {
      return serviceModel.name;
    } else if (title != null) {
      return title;
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
}
