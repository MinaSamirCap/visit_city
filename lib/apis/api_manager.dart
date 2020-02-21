import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..
import 'package:visit_city/models/feedback/feedback_wrapper.dart';
import '../models/feedback/feedback_send_model.dart';
import 'dart:convert';
import 'api_keys.dart';

class ApiManager with ChangeNotifier {
  Future<bool> feedbackApi(FeedbackSendModel feedbackModel) async {
    /// the post method will return a future so if I want to execute something after the api calling
    /// I need to add that in the .then() method ...
    /// also if I add something aftet the post method it will executed immediately because I did not
    /// add await and async in the function to wait for server response ....

    try {
      final response = await http.post(ApiKeys.feedbackUrl,
          headers: ApiKeys.getHeaders(),
          body: json.encode(feedbackModel.toJson()));

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return false;
      } else {
        print("extracted:$extractedData");
        FeedbackWrapper wrapper = FeedbackWrapper.fromJson(extractedData);
        if (wrapper.info) {
          return true;
        } else {
          return false;
        }
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
