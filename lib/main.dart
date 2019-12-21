import 'package:flutter/material.dart';
import 'package:visit_city/ui/screens/home_screen.dart';
import './ui/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.ROUTE_NAME: (ctx) => HomeScreen(),
      },
    );
  }
}
