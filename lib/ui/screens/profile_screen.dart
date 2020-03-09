// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../res/coolor.dart';
// import '../../utils/lang/app_localization.dart';
// import '../../utils/lang/app_localization_keys.dart';
// import '../../models/profile/profile_model.dart';
// import '../../apis/api_manager.dart';
// import '../../ui/screens/profile_update_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   static const ROUTE_NAME = '/profile-screen';

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   AppLocalizations _appLocal;
//   bool _isLoadingNow = false;
//   var _isInit = true;
//   List<ProfileModel> _profileList = [];

//   File _image;

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);

//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     List<ProfileModel> _loadedProfileList = [];
//     if (_isInit) {
//       if (mounted) {
//         setState(() {
//           _isLoadingNow = true;
//         });
//       }
//       Provider.of<ApiManager>(context, listen: false).profileApi().then((_) {
//         if (mounted) {
//           setState(() {
//             _loadedProfileList =
//                 Provider.of<ApiManager>(context, listen: false).profileData;
//             _profileList = _loadedProfileList;
//           });
//         }
//       }).then((_) {
//         if (mounted) {
//           setState(() {
//             _isLoadingNow = false;
//           });
//         }
//       });
//     }
//     _isInit = false;

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _appLocal = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_appLocal.translate(LocalKeys.PROFILE)),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.edit),
//               onPressed: () {
//                 Navigator.of(context).pushNamed(ProfileUpdateScreen.ROUTE_NAME);
//               })
//         ],
//       ),
//       body: _isLoadingNow
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//                       child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 120,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     child: Card(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Center(
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: 20,
//                             ),
//                             CircleAvatar(
//                               backgroundImage:
//                                   NetworkImage(_profileList[0].photo),
//                               // minRadius: 50,
//                               radius: 130,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: Text(
//                                 _profileList[0].name,
//                                 style: TextStyle(
//                                     fontSize: 25, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: Text(
//                                 _profileList[0].email,
//                                 style:
//                                     TextStyle(fontSize: 18, color: Coolor.GREY),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: Text(
//                                 _profileList[0].phone,
//                                 style:
//                                     TextStyle(fontSize: 18, color: Coolor.GREY),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: Text(
//                                 'Egypt',
//                                 style:
//                                     TextStyle(fontSize: 18, color: Coolor.GREY),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ),
//     );
//   }
// }
