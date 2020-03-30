import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../apis/api_keys.dart';
import '../../res/sizes.dart';

class FayoumIntroScreen extends StatefulWidget {
  static const ROUTE_NAME = '/fayoum-intro';

  @override
  _FayoumIntroScreenState createState() => _FayoumIntroScreenState();
}

class _FayoumIntroScreenState extends State<FayoumIntroScreen> {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String data = '';
  final dio = new Dio();

  @override
  void initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction about Fayoum'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
                      child: Container(
                width: double.infinity,
                margin: Sizes.EDEGINSETS_15,
                child: Text(
                  data,
                  style: TextStyle(fontSize:20),
                ),
              ),
          ),
    );
  }
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response =
          await dio.get(ApiKeys.aboutIntroUrl, options: Options(headers: await ApiKeys.getHeaders()));

      setState(() {
        isLoading = false;
        data = response.data['data']['intro'];
      });
    }
  }
}
