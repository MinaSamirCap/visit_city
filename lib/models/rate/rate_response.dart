import '../../models/rate/rate_model.dart';
import '../../models/base_paging.dart';

class RateResponse extends BaseBaging {
  List<RateModel> docs;

  RateResponse(this.docs, totalDocs, limit, totalPages, page, pagingCounter,
      hasPrevPage, hasNextPage, prevPage, nextPage)
      : super(totalDocs, limit, totalPages, page, pagingCounter, hasPrevPage,
            hasNextPage, prevPage, nextPage);

  RateResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    docs = (json['docs'] as List).map((item) {
      return RateModel.fromJson(item);
    }).toList();
  }

  static RateResponse clearPagin() {
    return RateResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}
