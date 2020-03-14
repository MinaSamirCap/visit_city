import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // to avoid crashing with names ..
import 'package:visit_city/prefs/pref_manager.dart';

import 'api_keys.dart';

import '../models/rate/rate_post_wrapper.dart';
import '../models/rate/rate_send_model.dart';
import '../models/sights_list/sights_list_wrapper.dart';
import '../models/rate/rate_wrapper.dart';
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
import '../models/unplan_sight_model.dart/unplan_sight_wrapper.dart';
import '../models/add_sight_model.dart/add_sight_wrapper.dart';
import '../models/profile/profile_wrapper.dart';

class ApiManager with ChangeNotifier {
  /// authonticated done ...
  void feedbackApi(
      FeedbackSendModel feedbackModel, Function success, Function fail) async {
    await http
        .post(ApiKeys.feedbackUrl,
            headers: await ApiKeys.getHeaders(),
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

  /// authonticated done ...
  void categoriesApi(Function success, Function fail) async {
    await http
        .get(ApiKeys.categoriesUrl, headers: await ApiKeys.getHeaders())
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

  /// authonticated done ...
  void exploreApi(
      int pageNum, String query, Function success, Function fail) async {
    await http
        .get(generateExploreUrl(pageNum, query),
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
      } else {
        ExploreWrapper wrapper = ExploreWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
        } else {
          fail(wrapper.message);
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void itinerariesApi(int id, Function success, Function fail) async {
    await http
        .get(ApiKeys.itinerariesUrl + '/$id',
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
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
        .get(generateWishlistUrl(pageNum), headers: await ApiKeys.getHeaders())
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

  /// authonticated done ...
  void likeDislikeApi(
      WishlistSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.likeDislikeUrl,
            headers: await ApiKeys.getHeaders(),
            body: json.encode(model.toJson()))
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

  void getSightDetails(String sightId, Function success, Function fail) async {
    await http
        .get(ApiKeys.sightDetailsUrl + sightId,
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
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

  /// authonticated done ...
  void getExploreDetails(int serviceId, Function success, Function fail) async {
    await http
        .get(ApiKeys.exploreDetailsUrl + serviceId.toString(),
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
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

  String generateServicesReviewUrl(int pageNum, int serviceId) {
    /// /reviews/service/3? +  limit=15 & page=1
    return ApiKeys.servicesReviewUrl +
        serviceId.toString() +
        "?" +
        ApiKeys.limitKey +
        "=" +
        ApiKeys.limitValue +
        "&" +
        ApiKeys.pageKey +
        "=" +
        pageNum.toString();
  }

  /// authonticated done ...
  void servicesReviewApi(
      int pageNum, int serviceId, Function success, Function fail) async {
    await http
        .get(generateServicesReviewUrl(pageNum, serviceId),
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        RateWrapper wrapper = RateWrapper.fromJson(extractedData);
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

  /// authonticated done ...
  void submitServiceReview(RateSendModel rateModel, int serviceId,
      Function success, Function fail) async {
    final finalUrl = ApiKeys.servicesReviewUrl + serviceId.toString();
    await http
        .post(finalUrl,
            headers: await ApiKeys.getHeaders(),
            body: json.encode(rateModel.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        // decode error;
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        RatePostWrapper wrapper = RatePostWrapper.fromJson(extractedData);
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

  String generateSightsReviewUrl(int pageNum, int sightId) {
    /// /reviews/service/3? +  limit=15 & page=1
    return ApiKeys.sightsReviewUrl +
        sightId.toString() +
        "?" +
        ApiKeys.limitKey +
        "=" +
        ApiKeys.limitValue +
        "&" +
        ApiKeys.pageKey +
        "=" +
        pageNum.toString();
  }

  void sightsReviewApi(
      int pageNum, int sightId, Function success, Function fail) async {
    await http
        .get(generateSightsReviewUrl(pageNum, sightId),
            headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        RateWrapper wrapper = RateWrapper.fromJson(extractedData);
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

  void submitSightsReview(RateSendModel rateModel, int sightId,
      Function success, Function fail) async {
    final finalUrl = ApiKeys.sightsReviewUrl + sightId.toString();
    await http
        .post(finalUrl,
            headers: await ApiKeys.getHeaders(),
            body: json.encode(rateModel.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        // decode error;
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        RatePostWrapper wrapper = RatePostWrapper.fromJson(extractedData);
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

  String generatePlanUrl(int pageNum) {
    /// /my-plan? + page=pageNum"
    return ApiKeys.getPlanUrl + ApiKeys.pageKey + "=" + pageNum.toString();
  }

  void getMyPlan(int pageNum, Function success, Function fail) async {
    await http
        .get(generatePlanUrl(pageNum), headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      // todo --> do not forget to remove the
      // print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        SightsListWrapper wrapper = SightsListWrapper.fromJson(extractedData);
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

  void removeSight(int sightId, Function success, Function fail) async {
    final msg = jsonEncode({
      'sights': [sightId]
    });
    await http
        .post(ApiKeys.removeSight,
            headers: await ApiKeys.getHeaders(), body: msg)
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        UnplanSightWrapper wrapper = UnplanSightWrapper.fromJson(extractedData);
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

  void addSight(int sightId, Function success, Function fail) async {
    final body = jsonEncode({
      'sights': [sightId]
    });
    await http
        .post(ApiKeys.addSight, headers: await ApiKeys.getHeaders(), body: body)
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        AddSightWrapper wrapper = AddSightWrapper.fromJson(extractedData);
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

  void addItinerary(int itinId, Function success, Function fail) async {
    await http
        .post(
      ApiKeys.addPlan + '$itinId',
      headers: await ApiKeys.getHeaders(),
    )
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        AddSightWrapper wrapper = AddSightWrapper.fromJson(extractedData);
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

  void getMixedItinerary(Function success, Function fail) async {
    await http
        .get(ApiKeys.mixedItinerary, headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);

      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        SightsListWrapper wrapper = SightsListWrapper.fromJson(extractedData);
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

  void getProfile(Function success, Function fail) async {
    await http
        .get(ApiKeys.profileUrl, headers: await ApiKeys.getHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        ProfileWrapper wrapper = ProfileWrapper.fromJson(extractedData);
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
