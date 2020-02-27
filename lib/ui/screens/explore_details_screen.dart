import 'package:flutter/material.dart';
import 'package:visit_city/models/explore/explore_model.dart';

class ExploreDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/explore-details';
  static const MODEL_KEY = 'explore_model';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final model = ExploreModel.fromJson(args[MODEL_KEY] as Map);

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
