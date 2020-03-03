import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..
import 'package:visit_city/models/wishlist/wishlist_send_model.dart';
import 'package:visit_city/models/wishlist/wishlist_wrapper.dart';
import '../models/explore/explore_wrapper.dart';
import '../models/category/category_wrapper.dart';
import '../models/feedback/feedback_wrapper.dart';
import '../models/message_model.dart';
import '../models/feedback/feedback_send_model.dart';
import 'dart:convert';
import 'api_keys.dart';

class ApiManager with ChangeNotifier {
  void feedbackApi(
      FeedbackSendModel feedbackModel, Function success, Function fail) async {
    await http
        .post(ApiKeys.feedbackUrl,
            headers: ApiKeys.getHeaders(),
            body: json.encode(feedbackModel.toJson()))
        .then((response) {
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
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void categoriesApi(Function success, Function fail) async {
    await http
        .get(ApiKeys.categoriesUrl, headers: ApiKeys.getHeaders())
        .then((response) {
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
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  String generateExploreUrl(int pageNum, String query) {
    /// /services-explored? + limit=15 + &page=1 +"category=1,2&page=2"
    if (query.isNotEmpty) {
      query = ApiKeys.categoryKey + "=" + query;
    }
    return ApiKeys.exploreUrl +
        ApiKeys.limitKey +
        "=" +
        ApiKeys.limitValue +
        "&" +
        ApiKeys.pageKey +
        "=" +
        pageNum.toString() +
        "&" +
        query;
  }

  void exploreApi(
      int pageNum, String query, Function success, Function fail) async {
    await http
        .get(generateExploreUrl(pageNum, query), headers: ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        ExploreWrapper wrapper = ExploreWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  String generateWishlistUrl(int pageNum) {
    /// /wishlist? + limit=15 + &page=1 +"category=1,2&page=2"
    return ApiKeys.wishlistUrl +
        ApiKeys.limitKey +
        "=" +
        ApiKeys.limitValue +
        "&" +
        ApiKeys.pageKey +
        "=" +
        pageNum.toString();
  }

  void wishlistApi(int pageNum, Function success, Function fail) async {
    await http
        .get(generateWishlistUrl(pageNum), headers: ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        WishlistWrapper wrapper = WishlistWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void likeDislikeApi(
      WishlistSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.wishlistUrl,
            headers: ApiKeys.getHeaders(), body: model.toJson())
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        WishlistWrapper wrapper = WishlistWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
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
