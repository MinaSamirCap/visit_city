import '../../models/base_paging.dart';
import '../../models/sights_list/sights_list_model.dart';

class SightsListResponse extends BaseBaging {
  List<SightsListModel> docs;

  SightsListResponse(this.docs, totalDocs, limit, totalPages, page, pagingCounter,
      hasPrevPage, hasNextPage, prevPage, nextPage)
      : super(totalDocs, limit, totalPages, page, pagingCounter, hasPrevPage,
            hasNextPage, prevPage, nextPage);

  SightsListResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    docs = (json['docs'] as List).map((item) {
      return SightsListModel.fromJson(item);
    }).toList();
  }

  static SightsListResponse clearPagin() {
    return SightsListResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}