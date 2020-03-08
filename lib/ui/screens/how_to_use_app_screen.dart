import 'package:flutter/material.dart';

class HowToUseAppScreen extends StatelessWidget {
  static const ROUTE_NAME = '/hot-to-use-app';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to use the Application'),
      ),
      body: Center(child: Text('How to use the application')),
    );
  }
}