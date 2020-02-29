import 'package:flutter/material.dart';

import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../ui/widget/itinerary_days_widget.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../ui/widget/ui.dart';
import '../../ui/widget/map_widget.dart';

class ItineraryDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/itinerary-details-screen';
  @override
  _ItineraryDetailsScreenState createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  AppLocalizations _appLocal;
  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          iconTheme: IconThemeData(color: Coolor.GREY_DARK),
          backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
          actions: <Widget>[
            Padding(
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
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MapWidget.ROUTE_NAME);
              },
              icon: Icon(Icons.map),
              color: Coolor.GREY_DARK,
            ),
          ],
          // title: itineraryTitle(),
          bottom: ItineraryDaysWidget(DayItem.getDaysList(_appLocal)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: backgroundImageWidget(),
          ),
          // backgroundImageWidget(),
          listWidget(),
        ],
      ),
    );
  }

  Widget itineraryTitle() {
    return Text(
      'Nature Itinerary',
      style: TextStyle(
        color: Coolor.GREY_DARK,
      ),
    );
  }

  Widget backgroundImageWidget() {
    return Image.asset(AssPath.NATURE_BACKGROUND);
  }

  Widget listWidget() {
    return ListView.separated(
      padding: Sizes.EDEGINSETS_8,
      separatorBuilder: (_, __) {
        return Sizes.DIVIDER_HEIGHT_10;
      },
      itemBuilder: (ctx, index) {
        return dayItemWidget(index);
      },
      itemCount: 5,
    );
  }

  Widget dayItemWidget(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: circleAvatarWidget(),
          title: sightCardItem(index),
        ),
      ],
    );
  }

  Widget circleAvatarWidget() {
    return CircleAvatar(
      maxRadius: Sizes.SIZE_30,
      backgroundImage: NetworkImage(
          "https://www.egypttoday.com/images/Uploads/2017/7/25/77710-1.jpg"),
      backgroundColor: Colors.transparent,
    );
  }

  Widget sightCardItem(int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: Sizes.BOR_RAD_20),
      child: ClipRRect(
        child: InkWell(
          onTap: () {
            print("object$index");
          },
          child: Container(
            height: 210,
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
                        'From Tunis',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    'Drive along the "Qarun Lake" on the North side, admire the contrast between desert and water: this is the habitat of about 35.000 species of birds.',
                  ),
                  Sizes.DIVIDER_HEIGHT_10,
                  lineDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.nature),
                          Icon(Icons.train),
                          Icon(Icons.pool),
                          Icon(Icons.airplanemode_active),
                          Icon(Icons.beach_access),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.near_me),
                            onPressed: () {},
                          ),
                          Text(
                            'GO',
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
    );
  }
}
