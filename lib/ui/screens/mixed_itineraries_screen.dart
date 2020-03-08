import 'package:flutter/material.dart';

import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../ui/widget/ui.dart';
import '../../res/assets_path.dart';

class MixedItinerariesScreen extends StatelessWidget {
  static const ROUTE_NAME = '/mixed-itineraries-screen';
  AppLocalizations _appLocal;
  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.MIXED_ITINERARIES)),
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
      itemCount: 6,
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
                // Map<String, dynamic> sightId = {
                //   "sight_id": _itinerariesData['data']['sights'][_value]
                //       ['sights'][index]['id']
                // };
                // Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,
                //     arguments: sightId);
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
                            'Tounis',
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
                          'Descrition',
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
                                    // if (_itinerariesData['data']['sights']
                                    //                 [_value]['sights'][index]
                                    //             ['location']
                                    //         .isNotEmpty &&
                                    //     _itinerariesData['data']['sights']
                                    //                     [_value]['sights']
                                    //                 [index]['location']
                                    //             .length ==
                                    //         2) {
                                    //   launchMap(
                                    //       _itinerariesData['data']['sights']
                                    //               [_value]['sights'][index]
                                    //           ['location'][0],
                                    //       _itinerariesData['data']['sights']
                                    //               [_value]['sights'][index]
                                    //           ['location'][1]);
                                    // }
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
         'How',
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
      backgroundImage:AssetImage(AssPath.APP_LOGO),
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
