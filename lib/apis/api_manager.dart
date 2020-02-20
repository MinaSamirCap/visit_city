import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..
import 'dart:convert';

import '../models/feedback_model.dart';

import 'api_keys.dart';

class ApiManager with ChangeNotifier {
  Future<bool> feedbackApi(FeedbackModel feedbackModel) async {
    /// the post method will return a future so if I want to execute something after the api calling
    /// I need to add that in the .then() method ...
    /// also if I add something aftet the post method it will executed immediately because I did not
    /// add await and async in the function to wait for server response ....

    final jsonBody = json.encode({
      'rate': feedbackModel.rate,
      'comment': feedbackModel.comment,
    });
    print(jsonBody);

    try {
      final response = await http.post(ApiKeys.feedbackUrl,
          headers: ApiKeys.getHeaders(), body: jsonBody);

      print(response.body);
      notifyListeners();
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
