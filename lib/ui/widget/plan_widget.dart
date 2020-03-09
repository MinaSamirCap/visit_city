import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/models/unplan_sight_model.dart/unplan_sight_wrapper.dart';

import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/plan/plan_model.dart';
import '../../models/plan/plan_response.dart';
import '../../models/plan/plan_wrapper.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../res/assets_path.dart';
import '../../general/url_launchers.dart';
import '../../ui/screens/sight_details_screen.dart';

class PlanWidget extends StatefulWidget {
  @override
  _PlanWidgetState createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  List<PlanModel> myPlan = [];
  PlanResponse _pagingInfo;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  bool _isLoadingNow = true;
  ScrollController _scrollController = new ScrollController();

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      clearPaging();
      callPlanApi();
    });
    super.initState();
  }

  void clearPaging() {
    myPlan.clear();
    _pagingInfo = PlanResponse.clearPagin();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    print(myPlan.toString() + " here");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.MY_PLAN)),
        centerTitle: true,
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _isLoadingNow ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
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
        if (index == myPlan.length) {
          return _buildProgressIndicator();
        } else {
          return sightItemWidget(index);
        }
      },
      itemCount: myPlan.length + 1,
    );
  }

  Widget sightItemWidget(int index) {
    PlanModel model = myPlan[index];
    return ListTile(
      leading: circleAvatarWidget(model),
      title: sightCardItem(model,index),
    );
  }

  Widget sightCardItem(PlanModel model,int index) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                Map<String, dynamic> sightId = {
                  "sight_id": model.id,
                };
                Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,
                    arguments: sightId);
              },
              child: Container(
                height: 215,
                decoration: BoxDecoration(
                    borderRadius: Sizes.BOR_RAD_20,
                    border: Border.all(color: Coolor.GREY, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                callRemoveSightApi(model.id);
                                myPlan.removeAt(index);
                              });
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              _appLocal.translate(LocalKeys.FROM) +
                                  " " +
                                  model.openHours.from +
                                  " " +
                                  _appLocal.translate(LocalKeys.TO) +
                                  " " +
                                  model.openHours.to,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
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

  Widget circleAvatarWidget(PlanModel model) {
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

  void callPlanApi() async {
    _progressDialog.show();
    _apiManager.getMyPlan(_pagingInfo.page + 1, (PlanWrapper wrapper) {
      _progressDialog.hide();
      setState(() {
        myPlan.addAll(wrapper.data.docs);
        _pagingInfo = wrapper.data;
        _isLoadingNow = false;
        if (!_pagingInfo.hasNextPage) {
          showSnackBar(
              createSnackBar(_appLocal.translate(LocalKeys.NO_MORE_DATA)),
              _scaffoldKey);
        }
      });
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  void callRemoveSightApi(int sightId) async {
    _apiManager.removeSight(sightId, (UnplanSightWrapper wrapper) {
      setState(() {
        _isLoadingNow = false;
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
