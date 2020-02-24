import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..
import '../models/category/category_wrapper.dart';
import '../models/feedback/feedback_wrapper.dart';
import '../models/message_model.dart';
import '../models/feedback/feedback_send_model.dart';
import 'dart:convert';
import 'api_keys.dart';

class ApiManager with ChangeNotifier {
  Future<bool> feedbackApi(
      FeedbackSendModel feedbackModel, Function success, Function fail) async {
    try {
      final response = await http.post(ApiKeys.feedbackUrl,
          headers: ApiKeys.getHeaders(),
          body: json.encode(feedbackModel.toJson()));

      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        // decode error;
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        FeedbackWrapper wrapper = FeedbackWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    } catch (error) {
      /// still not sure if it is working well or not
      fail(checkErrorType(error));
      return false;
    }
  }

  Future<bool> categoriesApi(Function success, Function fail) async {
    try {
      final response =
          await http.get(ApiKeys.categoriesUrl, headers: ApiKeys.getHeaders());

      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        CategoryWrapper wrapper = CategoryWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    } catch (error) {
      fail(checkErrorType(error));
      return false;
    }
  }

  MessageModel checkErrorType(Error error) {
    print(error.toString());
    if (error is HttpException) {
      return MessageModel.getHttpException(error as HttpException);
    } else if (error is TypeError) {
      return MessageModel.getTypeError(error);
    } else {
      return MessageModel.getUnknownError();
    }
  }
}
