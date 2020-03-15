import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:visit_city/models/rate/user_model.dart';
import 'package:visit_city/res/assets_path.dart';
import 'package:visit_city/ui/base/base_state.dart';

import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../apis/api_manager.dart';
import '../../ui/screens/profile_update_screen.dart';
import '../../models/profile/profile_wrapper.dart';
import '../../models/profile/profile_response.dart';
import '../../models/message_model.dart';
import '../../ui/widget/ui.dart';
import '../../res/sizes.dart';

class ProfileScreen extends StatefulWidget {
  static const ROUTE_NAME = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with BaseState {
  AppLocalizations _appLocal;
  UserModel profileInfo;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  bool _isLoadingNow = true;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
      callGetProfileApi();
    });
    super.initState();
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.PROFILE)),
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: () {
        //         Navigator.of(context).pushNamed(ProfileUpdateScreen.ROUTE_NAME);
        //       })
        // ],
      ),
      body: _isLoadingNow
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                              backgroundImage: profileInfo.photo == null
                                  ? AssetImage(AssPath.APP_LOGO)
                                  : NetworkImage(profileInfo.photo),
                              // minRadius: 50,
                              radius: 130,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                profileInfo.name,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                profileInfo.email,
                                style:
                                    TextStyle(fontSize: 18, color: Coolor.GREY),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: profileInfo.phone == null
                                  ? Text('none')
                                  : Text(
                                      profileInfo.phone,
                                      style: TextStyle(
                                          fontSize: 18, color: Coolor.GREY),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: profileInfo.country == null
                                  ? Text('')
                                  : Text(
                                      profileInfo.country,
                                      style: TextStyle(
                                          fontSize: 18, color: Coolor.GREY),
                                    ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void callGetProfileApi() async {
    // _progressDialog.show();
    _apiManager.getProfile((ProfileWrapper wrapper) {
      // _progressDialog.hide();
      setState(() {
        profileInfo = wrapper.data;
        _isLoadingNow = false;
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      // _progressDialog.hide();
      setState(() {
        _isLoadingNow = false;
      });
    });
  }

  @override
  BuildContext provideContext() {
    return context;
  }
}
