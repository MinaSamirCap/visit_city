import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  static const ROUTE_NAME = '/feedback-screen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Center(
        child: Text("Feedback"),
      ),
    );
  }
}
