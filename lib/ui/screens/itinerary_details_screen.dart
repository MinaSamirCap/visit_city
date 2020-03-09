import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:visit_city/models/itineraries/day_model.dart';

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
import '../../models/itineraries/itineraries_wrapper.dart';
import '../../models/message_model.dart';
import '../../ui/widget/line_painter.dart';

class ItineraryDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/itinerary-details-screen';
  static const MODEL_ID_KEY = 'itinerary_id';
  @override
  _ItineraryDetailsScreenState createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  bool _isLoadingNow = true;
  int _value = 0;
  List<DayItem> _daysList;
  List<DayModel> itinerariesList = [];
  ApiManager _apiManager;
  ProgressDialog _progressDialog;
  int itineraryId = 0;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      callItinerariesApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    _daysList = DayItem.getDaysList(_appLocal);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    itineraryId = args[ItineraryDetailsScreen.MODEL_ID_KEY];
    print(itinerariesList);

    return _isLoadingNow
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
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
          );
  }

  Widget listWidget() {
    DayModel model = itinerariesList[_value];
    return ListView.separated(
      padding: Sizes.EDEGINSETS_8,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        return sightItemWidget(index, model);
      },
      itemCount: model.sightsDay.length,
    );
  }

  Widget sightItemWidget(int index, DayModel model) {
    return ListTile(
      // leading: CustomPaint(
      //   painter: LinePainter(),
      //   child: circleAvatarWidget(model, index),
      // ),
      leading: circleAvatarWidget(model, index),
      title: sightCardItem(model, index),
    );
  }

  Widget sightCardItem(DayModel model, int index) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
          child: ClipRRect(
            child: InkWell(
              onTap: () {
                Map<String, dynamic> sightId = {
                  "sight_id": model.sightsDay[index].id
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
                            model.sightsDay[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                // _addSight(model.sightsDay[index].id);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 65,
                        child: Text(model.sightsDay[index].desc),
                      ),
                      Sizes.DIVIDER_HEIGHT_10,
                      lineDivider(),
                      halfSightWidget(model, index),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        howToGoWidget(model, index),
      ],
    );
  }

  Widget halfSightWidget(DayModel model, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            _appLocal.translate(LocalKeys.FROM) +
                " " +
                model.sightsDay[index].openHours.from +
                " " +
                _appLocal.translate(LocalKeys.TO) +
                " " +
                model.sightsDay[index].openHours.to,
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
                  if (model.sightsDay[index].location.isNotEmpty &&
                      model.sightsDay[index].location.length == 2) {
                    launchMap(model.sightsDay[index].location[0],
                        model.sightsDay[index].location[1]);
                  }
                }),
            Text(
              _appLocal.translate(LocalKeys.GO),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget howToGoWidget(DayModel model, int index) {
    return Text(
      model.sightsDay[index].how,
      style: TextStyle(color: Coolor.WHITE),
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

  Widget circleAvatarWidget(DayModel model, int index) {
    return CircleAvatar(
      radius: Sizes.SIZE_30,
      backgroundImage: NetworkImage(model.sightsDay[index].photos[0]),
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
        onPressed: () {
          setState(() {
            // _setAsMyPlan();
          });
        },
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
              itemCount: itinerariesList.length,
              itemBuilder: (ctx, index) {
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

  void callItinerariesApi() async {
    _progressDialog.show();
    _apiManager.itinerariesApi(itineraryId, (ItinerariesWrapper wrapper) {
      _progressDialog.hide();
      setState(() {
        itinerariesList.addAll(wrapper.data.daysList);
        _isLoadingNow = false;
      });
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
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
