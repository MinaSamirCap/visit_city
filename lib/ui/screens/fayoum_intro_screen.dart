import 'package:flutter/material.dart';

class FayoumIntroScreen extends StatelessWidget {
  static const ROUTE_NAME = '/fayoum-intro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction about Fayoum'),
      ),
      body: Center(child: Text('Introduction about Fayoum')),
    );
  }
}
