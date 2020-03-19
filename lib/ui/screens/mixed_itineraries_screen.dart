import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/sights_list/sights_list_model.dart';
import '../../models/sights_list/sights_list_response.dart';
import '../../models/sights_list/sights_list_wrapper.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../res/assets_path.dart';
import '../../general/url_launchers.dart';
import '../../ui/screens/sight_details_screen.dart';
import '../../ui/base/base_state.dart';

class MixedItinerariesScreen extends StatefulWidget {
  static const ROUTE_NAME = '/mixed-itineraries-screen';

  @override
  _MixedItinerariesScreenState createState() => _MixedItinerariesScreenState();
}

class _MixedItinerariesScreenState extends State<MixedItinerariesScreen> with BaseState{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  List<SightsListModel> mixedList = [];
  SightsListResponse _pagingInfo;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  bool _isLoadingNow = true;
  ScrollController _scrollController = new ScrollController();

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      clearPaging();
      callMixedItinApi();
    });
    super.initState();
  }

  void clearPaging() {
    mixedList.clear();
    _pagingInfo = SightsListResponse.clearPagin();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.MIXED_ITINERARIES)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: backgroundImageWidget(),
          ),
          listWidget(),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget listWidget() {
    return ListView.separated(
      controller: _scrollController,
      padding: Sizes.EDEGINSETS_8,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        if (index == mixedList.length) {
          return null;
        } else {
          return sightItemWidget(index);
        }
      },
      itemCount: mixedList.length + 1,
    );
  }

  Widget sightItemWidget(int index) {
    SightsListModel model = mixedList[index];
    return ListTile(
      leading: circleAvatarWidget(model),
      title: sightCardItem(model),
    );
  }

  Widget sightCardItem(SightsListModel model) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,
                    arguments: {SightDetailsScreen.MODEL_ID_KEY: model.id.toString()});
              },
              child: Container(
                height: 217,
                decoration: BoxDecoration(
                    borderRadius: Sizes.BOR_RAD_20,
                    border: Border.all(color: Coolor.GREY, width: 1)),
                child: Padding(
                  padding: Sizes.EDEGINSETS_8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            model.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              callAddSightApi(model.id);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 65,
                        child: Text(
                          model.desc,
                        ),
                      ),
                      Sizes.DIVIDER_HEIGHT_10,
                      lineDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _appLocal.translate(LocalKeys.FROM) +
                                      " " +
                                      model.openHours.from,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _appLocal.translate(LocalKeys.TO) +
                                      " " +
                                      model.openHours.to,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.near_me),
                                  onPressed: () {
                                    if (model.location.isNotEmpty &&
                                        model.location.length == 2) {
                                      launchMap(
                                          model.location[0], model.location[1]);
                                    }
                                  }),
                              Text(
                                _appLocal.translate(LocalKeys.GO),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: Coolor.WHITE,
      thickness: 20,
      width: 50,
      indent: 200,
      endIndent: 200,
    );
  }

  Widget circleAvatarWidget(SightsListModel model) {
    return CircleAvatar(
      maxRadius: Sizes.SIZE_30,
      backgroundImage: NetworkImage(model.photos[0]),
      backgroundColor: Colors.transparent,
    );
  }

  Widget backgroundImageWidget() {
    return Image.asset(
      AssPath.NATURE_BACKGROUND,
      fit: BoxFit.cover,
    );
  }

  void callMixedItinApi() async {
    _progressDialog.show();
    _apiManager.getMixedItinerary((SightsListWrapper wrapper) {
      _progressDialog.hide();
      setState(() {
        mixedList.addAll(wrapper.data.docs);
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
      _progressDialog.hide();
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  void callAddSightApi(int sightId) async {
    _apiManager.addSight(sightId, (SightsListWrapper wrapper) {
      setState(() {
        _isLoadingNow = false;
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }
  @override
  BuildContext provideContext() {
    return context;
  }
}
