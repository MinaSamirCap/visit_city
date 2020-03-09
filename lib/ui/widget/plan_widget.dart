import 'package:flutter/material.dart';

import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../res/assets_path.dart';
import 'package:dio/dio.dart';
import '../../apis/api_keys.dart';
import '../../general/url_launchers.dart';
import '../../ui/screens/sight_details_screen.dart';

class PlanWidget extends StatefulWidget {
  @override
  _PlanWidgetState createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  AppLocalizations _appLocal;
  String url = "https://visit-fayoum.herokuapp.com/api/v1/my-plan?page=1";
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List data = new List();
  final dio = new Dio();

  @override
  void initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _removeSight(int sightId) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response = await dio.post(
          'https://visit-fayoum.herokuapp.com/api/v1/unplan-sights',
          options: Options(headers: ApiKeys.getHeaders()),
          data: {
            'sights': [sightId]
          });

      setState(() {
        _getMoreData();
        isLoading = false;
      });
    }
  }

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response =
          await dio.get(url, options: Options(headers: ApiKeys.getHeaders()));
      if (response.data['data']['totalDocs'] == data.length) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No more data to load"),
        ));
      }
      print(response.data['data']['totaldocs']);
      List tempList = [];
      url = "https://visit-fayoum.herokuapp.com/api/v1/my-plan?page=" +
          (response.data['data']['page'] + 1).toString();
      for (int i = 0; i < response.data['data']['docs'].length; i++) {
        tempList.add(response.data['data']['docs'][i]);
      }

      setState(() {
        isLoading = false;
        data.addAll(tempList);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
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

  Widget listWidget() {
    return ListView.separated(
      controller: _scrollController,
      padding: Sizes.EDEGINSETS_8,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        if (index == data.length) {
          return _buildProgressIndicator();
        } else {
          return sightItemWidget(index);
        }
      },
      itemCount: data.length + 1,
    );
  }

  Widget sightItemWidget(int index) {
    return ListTile(
      leading: circleAvatarWidget(index),
      // verticalDivider(),
      title: sightCardItem(index),
    );
  }

  Widget sightCardItem(int index) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                print("object$index");
                Map<String, dynamic> sightId = {
                  "sight_id": data[index]['id'],
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
                            data[index]['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _removeSight(data[index]['id']);
                                data.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 65,
                        child: Text(
                          data[index]['desc'],
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
                              'From: ' +
                                  data[index]['openHours']['from'] +
                                  ' to ' +
                                  data[index]['openHours']['to'],
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
                                    if (data[index]['location'].isNotEmpty &&
                                        data[index]['location'].length == 2) {
                                      launchMap(data[index]['location'][0],
                                          data[index]['location'][1]);
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

  Widget circleAvatarWidget(int index) {
    return CircleAvatar(
      maxRadius: Sizes.SIZE_30,
      backgroundImage: NetworkImage(data[index]['photos'][0]),
      backgroundColor: Colors.transparent,
    );
  }

  Widget backgroundImageWidget() {
    return Image.asset(
      AssPath.NATURE_BACKGROUND,
      fit: BoxFit.cover,
    );
  }
}
