import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:visit_city/ui/screens/profile_screen.dart';

import '../../models/profile_update/profile_update_wrapper.dart';
import '../../models/rate/user_model.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../apis/api_manager.dart';
import '../../models/profile_update/profile_send_model.dart';
import '../../apis/api_keys.dart';
import '../../models/message_model.dart';
import '../../ui/widget/ui.dart';

class ProfileUpdateScreen extends StatefulWidget {
  static const ROUTE_NAME = '/update-profile-screen';

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final dio = new Dio();
  bool _isLoadingNow = false;
  AppLocalizations _appLocal;
  String _storedImagePath;
  File _image;
  UserModel _profileInfo;
  ProfileSendModel model = ProfileSendModel();
  ProgressDialog _progressDialog;
  ApiManager _apiManager;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as UserModel;
    _profileInfo = args;
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.EDIT_PROFILE)),
        ),
        body: _isLoadingNow
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _profilePictureWidget(),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: _personalInformationRow(),
                                ),
                                _formWidget(),
                                !_status
                                    ? _getActionButtons()
                                    : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(_appLocal.translate(LocalKeys.SAVE)),
                textColor: Colors.white,
                color: Coolor.BLUE_APP,
                onPressed: () {
                  _status = true;
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  if (model.name != null ||
                      model.email != null ||
                      model.phone != null ||
                      model.country != null) {
                    callProfileUpdateApi();
                  }
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text(_appLocal.translate(LocalKeys.CANCEL)),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  void _profileImageUpdate() async {
    if (!_isLoadingNow) {
      setState(() {
        _isLoadingNow = true;
      });
      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(_storedImagePath),
      });

      await dio.patch(ApiKeys.profileUrl,
          options: Options(
            headers: await ApiKeys.getHeaders(),
          ),
          data: formData);
      if (mounted) {
        setState(() {
          _isLoadingNow = false;
        });
      }
    }
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Coolor.BLUE_APP,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Future getImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: Sizes.SIZE_600,
    );
    if (imageFile == null) {
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    setState(() {
      _image = imageFile;
      _storedImagePath = savedImage.path;
    });
  }

  Widget _profilePictureWidget() {
    return Container(
      height: 250.0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: new Stack(fit: StackFit.loose, children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: _image == null
                              ? NetworkImage(_profileInfo.photo)
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 90.0, left: 100.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Coolor.GREY,
                        radius: 25.0,
                        child: new IconButton(
                          onPressed: () {
                            getImage().then((_) {
                              if (_image != null) {
                                _profileImageUpdate();
                              }
                            });
                          },
                          icon: Icon(Icons.camera_alt),
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
            ]),
          )
        ],
      ),
    );
  }

  Widget _personalInformationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              _appLocal.translate(LocalKeys.PERSONAL_INFORMATION),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _status ? _getEditIcon() : new Container(),
          ],
        )
      ],
    );
  }

  void callProfileUpdateApi() async {
    _progressDialog.show();
    _apiManager.updateProfileApis(model, (ProfileUpdateWrapper wrapper) {
      _progressDialog.hide();
      setState(() {
        _isLoadingNow = false;
        Navigator.of(context).popAndPushNamed(ProfileScreen.ROUTE_NAME);
      });
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      setState(() {
        _isLoadingNow = false;
      });
    });
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        _appLocal.translate(LocalKeys.NAME),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      decoration: InputDecoration(
                        labelText: _profileInfo.name,
                      ),
                      onSaved: (value) {
                        if (value != "") {
                          model.name = value;
                        } else {
                          model.name = _profileInfo.name;
                        }
                      },
                      enabled: !_status,
                      autofocus: !_status,
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        _appLocal.translate(LocalKeys.EMAIL),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(labelText: _profileInfo.email),
                      enabled: !_status,
                      onSaved: (value) {
                        if (value != "") {
                          model.email = value;
                        } else {
                          model.email = _profileInfo.email;
                        }
                      },
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        _appLocal.translate(LocalKeys.MOBILE),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: _profileInfo.phone),
                      enabled: !_status,
                      onSaved: (value) {
                        if (value != "") {
                          model.phone = value;
                        } else {
                          model.phone = _profileInfo.phone;
                        }
                      },
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        _appLocal.translate(LocalKeys.COUNTRY),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      decoration:
                          InputDecoration(labelText: _profileInfo.country),
                      enabled: !_status,
                      onSaved: (value) {
                        if (value != "") {
                          model.country = value;
                        } else {
                          model.country = _profileInfo.country;
                        }
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
