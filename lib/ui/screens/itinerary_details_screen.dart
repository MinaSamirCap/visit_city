import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../ui/widget/ui.dart';
import '../../ui/widget/map_widget.dart';
import '../../apis/api_manager.dart';
import '../../general/url_launchers.dart';
import '../../ui/screens/sight_details_screen.dart';

class ItineraryDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/itinerary-details-screen';
  @override
  _ItineraryDetailsScreenState createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  Map<String, dynamic> _itinerariesData;
  int _value = 0;
  AppLocalizations _appLocal;
  bool _isLoadingNow = false;
  var _isInit = true;
  List<DayItem> _daysList;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    final argsId = ModalRoute.of(context).settings.arguments as int;
    Map<String, dynamic> data;
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isLoadingNow = true;
        });
      }
      Provider.of<ApiManager>(context, listen: false)
          .itinerariesApi(argsId)
          .then((_) {
        if (mounted) {
          setState(() {
            data =
                Provider.of<ApiManager>(context, listen: false).extractedData;
            _itinerariesData = data;
          });
        }
      }).then((_) {
        if (mounted) {
          setState(() {
            // data = [];
            _isLoadingNow = false;
          });
        }
      });
    }
    // _eventData = [];
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    _daysList = DayItem.getDaysList(_appLocal);

    return _isLoadingNow
        ? Scaffold(
            key: _scaffoldKey,
            body: Center(child: CircularProgressIndicator()),
          )
        : DefaultTabController(
            length: _itinerariesData['data']['sights'].length,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(140),
                child: AppBar(
                  iconTheme: IconThemeData(color: Coolor.GREY_DARK),
                  backgroundColor: Coolor.WHITE,
                  bottom: appBarDaysWidget(),
                  actions: <Widget>[
                    setAsMyPlanButton(),
                    mapIcon(),
                  ],
                ),
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
            ),
          );
  }

  Widget listWidget() {
    return ListView.separated(
      padding: Sizes.EDEGINSETS_8,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        return sightItemWidget(index);
      },
      itemCount: _itinerariesData['data']['sights'][_value]['sights'].length,
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
                Map<String,dynamic> sightId = {"sight_id":_itinerariesData['data']['sights'][_value]['sights']
                                [index]['id']};
                Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,arguments:sightId );

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
                            _itinerariesData['data']['sights'][_value]['sights']
                                [index]['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 65,
                        child: Text(
                          _itinerariesData['data']['sights'][_value]['sights']
                              [index]['desc'],
                        ),
                      ),
                      Sizes.DIVIDER_HEIGHT_10,
                      lineDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Text(_itinerariesData['data']['sights'][_value]
                          //     ['sights'][index]['']),
                          Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.near_me),
                                  onPressed: () {
                                    if (_itinerariesData['data']['sights']
                                                    [_value]['sights'][index]
                                                ['location']
                                            .isNotEmpty &&
                                        _itinerariesData['data']['sights']
                                                        [_value]['sights']
                                                    [index]['location']
                                                .length ==
                                            2) {
                                      launchMap(
                                          _itinerariesData['data']['sights']
                                                  [_value]['sights'][index]
                                              ['location'][0],
                                          _itinerariesData['data']['sights']
                                                  [_value]['sights'][index]
                                              ['location'][1]);
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
        Text(
          _itinerariesData['data']['sights'][_value]['sights'][index]['how'],
          style: TextStyle(color: Coolor.WHITE),
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
      backgroundImage: NetworkImage(_itinerariesData['data']['sights'][_value]
          ['sights'][index]['photos'][0]),
      backgroundColor: Colors.transparent,
    );
  }

  Widget backgroundImageWidget() {
    return Image.asset(
      AssPath.NATURE_BACKGROUND,
      fit: BoxFit.cover,
    );
  }

  Widget setAsMyPlanButton() {
    return Padding(
      padding: Sizes.EDEGINSETS_10,
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: Sizes.BOR_RAD_35,
          side: BorderSide(
            color: Coolor.GREY_DARK,
          ),
        ),
        child: Text(
          _appLocal.translate(
            LocalKeys.SET_AS_MY_PLAN,
          ),
        ),
      ),
    );
  }

  Widget mapIcon() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(MapWidget.ROUTE_NAME);
      },
      icon: Icon(Icons.map),
      color: Coolor.GREY_DARK,
    );
  }

  Widget appBarDaysWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Column(children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _itinerariesData['data']['sights'].length,
              itemBuilder: (ctx, index) {
                // return;
                return appBarDaysItemWidget(_daysList[index], index);
              },
              separatorBuilder: (_, __) {
                return Sizes.DIVIDER_WIDTH_50;
              },
            ),
          ),
        ),
        Sizes.DIVIDER_HEIGHT_10,
      ]),
    );
  }

  Widget appBarDaysItemWidget(DayItem item, int index) {
    return Column(
      children: <Widget>[
        Text(
          _appLocal.translate(LocalKeys.DAY),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Coolor.GREY_DARK,
          ),
        ),
        ChoiceChip(
          label: Text(item.title),
          selected: _value == index,
          selectedColor: Coolor.MENU_SEL_COL,
          onSelected: (selected) {
            setState(() {
              _value = selected ? index : index;
              print(_value);
            });
          },
        ),
      ],
    );
  }
}

class DayItem {
  String title;

  DayItem({
    @required this.title,
  });

  static List<DayItem> getDaysList(AppLocalizations appLocale) {
    return [
      DayItem(
        title: appLocale.translate(LocalKeys.ONE),
      ),
      DayItem(
        title: appLocale.translate(LocalKeys.TWO),
      ),
      DayItem(
        title: appLocale.translate(LocalKeys.THREE),
      ),
      DayItem(
        title: appLocale.translate(LocalKeys.FOUR),
      ),
      DayItem(
        title: appLocale.translate(LocalKeys.FIVE),
      ),
      DayItem(
        title: appLocale.translate(LocalKeys.SIX),
      ),
    ];
  }
}
