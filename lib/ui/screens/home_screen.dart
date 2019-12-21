import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE_NAME = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Visit a City'),
        ),
        body: Center(
          child: Text("Fayoum"),
        ));
  }
}
