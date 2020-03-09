import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/models/wishlist/like_dislike_wrapper.dart';
import 'package:visit_city/models/wishlist/wishlist_model.dart';
import 'package:visit_city/models/wishlist/wishlist_send_model.dart';
import 'package:visit_city/ui/widget/explore_cell_widget.dart';
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

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  SightResponse sightModel;
  int sightId = 0;
  int _currentTab = 0;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
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
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: Sizes.hightDetails,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[favIcon()],
                  flexibleSpace: FlexibleSpaceBar(
                      title: Text(getTitle()),
                      background: sightModel != null
                          ? CarouselWithIndicator(sightModel.photos)
                          : getCenterCircularProgress()),
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
            body:
                sightModel != null ? bodyWidget() : getCenterCircularProgress(),
          ),
        ));
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
    return Center(
      child: Text(sightModel.name),
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

  void callDetailsApi() async {
    _progressDialog.show();
    _apiManager.getSightDetails(sightId, (SightWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        sightModel = wrapper.data;
      });
    }, (MessageModel messageModel) {
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
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
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
}
