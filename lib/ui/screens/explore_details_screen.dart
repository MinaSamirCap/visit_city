import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
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
      appBar: AppBar(
        title: Text(getTitle(serviceModel.name)),
      ),
      body: serviceModel != null
          ? bodyWidget()
          : Center(
              child: Text(serviceModel.desc),
            ),
    );
  }

  Widget bodyWidget() {
    return Center(
      child: Text(serviceModel.desc +
          " " +
          serviceModel.desc +
          " " +
          serviceModel.desc),
    );
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
