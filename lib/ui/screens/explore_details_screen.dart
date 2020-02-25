import 'package:flutter/material.dart';

class ExploreDetailsScreen extends StatelessWidget {

  static const ROUTE_NAME = '/explore-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detais"),
      ),
      body: Center(child: Text("Detaisl"),),
    );
  }
}