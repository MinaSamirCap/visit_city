import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..

import 'api_keys.dart';
import '../models/explore/service_wrapper.dart';
import '../models/sight/sight_wrapper.dart';
import '../models/wishlist/like_dislike_wrapper.dart';
import '../models/wishlist/wishlist_send_model.dart';
import '../models/wishlist/wishlist_wrapper.dart';
import '../models/explore/explore_wrapper.dart';
import '../models/category/category_wrapper.dart';
import '../models/feedback/feedback_wrapper.dart';
import '../models/message_model.dart';
import '../models/feedback/feedback_send_model.dart';
import '../models/itineraries/itineraries_wrapper.dart';

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

  void itinerariesApi(int id, Function success, Function fail) async {
    await http
        .get(ApiKeys.itinerariesUrl + '/$id', headers: ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      // print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        ItinerariesWrapper wrapper = ItinerariesWrapper.fromJson(extractedData);
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
        .post(ApiKeys.likeDislikeUrl,
            headers: ApiKeys.getHeaders(), body: json.encode(model.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        LikeDislikeWrapper wrapper = LikeDislikeWrapper.fromJson(extractedData);
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

  void getSightDetails(int sightId, Function success, Function fail) async {
    await http
        .get(ApiKeys.sightDetailsUrl + sightId.toString(),
            headers: ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      // todo --> do not forget to remove the
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        SightWrapper wrapper = SightWrapper.fromJson(extractedData);
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

  void getExploreDetails(int serviceId, Function success, Function fail) async {
    await http
        .get(ApiKeys.exploreDetailsUrl + serviceId.toString(),
            headers: ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      // todo --> do not forget to remove the
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        ServiceWrapper wrapper = ServiceWrapper.fromJson(extractedData);
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
