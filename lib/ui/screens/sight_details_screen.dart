import 'package:flutter/material.dart';
import 'package:visit_city/models/wishlist/wishlist_model.dart';

class SightDetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = '/sight-details';
  static const MODEL_KEY = 'sight_model';

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final model = WishlistModel.fromJson(args[SightDetailsScreen.MODEL_KEY] as Map);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
      ),
      body: Center(
        child: Text(model.desc),
      ),
    );
  }
}
