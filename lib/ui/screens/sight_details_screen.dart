import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/apis/api_manager.dart';
import 'package:visit_city/models/message_model.dart';
import 'package:visit_city/models/sight/sight_response.dart';
import 'package:visit_city/models/sight/sight_wrapper.dart';
import 'package:visit_city/models/wishlist/wishlist_model.dart';
import 'package:visit_city/ui/widget/ui.dart';
import 'package:visit_city/utils/lang/app_localization.dart';

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
      appBar: AppBar(
        title: Text(getTitle(model.name)),
      ),
      body: sightModel !=null? bodyWidget(): Center(
        child: Text(model.desc),
      ),
    );
  }

  Widget bodyWidget(){
    return Center(
        child: Text(sightModel.desc + " " + sightModel.desc + " " + sightModel.desc),
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
