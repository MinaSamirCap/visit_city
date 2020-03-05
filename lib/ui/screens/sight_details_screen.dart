import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/ui/widget/silver_app_bar_delegation.dart';
import '../../res/sizes.dart';
import '../../apis/api_manager.dart';
import '../../models/message_model.dart';
import '../../models/sight/sight_response.dart';
import '../../models/sight/sight_wrapper.dart';
import '../../models/wishlist/wishlist_model.dart';
import '../../ui/widget/ui.dart';
import '../../utils/lang/app_localization.dart';

class SightDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/sight-details';
  static const MODEL_KEY = 'sight_model';

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  SightResponse sightModel;

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
    final model =
        WishlistModel.fromJson(args[SightDetailsScreen.MODEL_KEY] as Map);

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
                      centerTitle: true,
                      title: Text("Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Tab 1"),
                        Tab(text: "Tab 2"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: sightModel != null
                ? bodyWidget()
                : Center(
                    child: Text(model.desc),
                  ),
          ),
        ));
  }

  Widget bodyWidget() {
    return Center(
      child:
          Text(sightModel.desc + " " + sightModel.desc + " " + sightModel.desc),
    );
  }

  void callDetailsApi() async {
    _progressDialog.show();
    _apiManager.getSightDetails(2, (SightWrapper wrapper) {
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

  String getTitle(String title) {
    if (sightModel != null) {
      return sightModel.name;
    } else if (title != null) {
      return title;
    } else {
      return "";
    }
  }
}
