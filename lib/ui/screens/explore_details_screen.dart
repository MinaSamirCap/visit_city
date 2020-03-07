import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
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
  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  ExploreModel serviceModel;
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
    serviceModel =
        ExploreModel.fromJson(args[ExploreDetailsScreen.MODEL_KEY] as Map);
    _appLocal = AppLocalizations.of(context);

    return Scaffold(
        key: _scaffoldKey,
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
            body: serviceModel != null
                ? bodyWidget()
                : Center(
                    child: Text(serviceModel.desc),
                  ),
          ),
        ));
  }

  Widget bodyWidget() {
    if (_currentTab == 0) {
      return overviewWidget(_appLocal, serviceModel.rate, serviceModel.location,
          serviceModel.desc, serviceModel.openHours, serviceModel.price, null, null);
    } else {
      return reviewWidget();
    }
  }

  Widget reviewWidget() {
    return Center(
      child: Text(serviceModel.name),
    );
  }

  Widget getPhotosOrDummyWidget() {
    if (serviceModel.photos.length > 0) {
      return CarouselWithIndicator(serviceModel.photos);
    } else {
      return Center(
        child: Text(_appLocal.translate(LocalKeys.NO_PIC)),
      );
    }
  }

  void callDetailsApi() async {
    _progressDialog.show();
    _apiManager.getExploreDetails(serviceModel.id, (ServiceWrapper wrapper) {
      setState(() {
        _progressDialog.hide();
        serviceModel = wrapper.data;
      });
    }, (MessageModel messageModel) {
      setState(() {
        _progressDialog.hide();
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
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
}
