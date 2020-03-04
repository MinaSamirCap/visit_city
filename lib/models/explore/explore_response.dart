import '../../models/explore/explore_model.dart';
import '../base_paging.dart';

class ExploreResponse extends BaseBaging {
  List<ExploreModel> docs;

  ExploreResponse(this.docs, totalDocs, limit, totalPages, page, pagingCounter,
      hasPrevPage, hasNextPage, prevPage, nextPage)
      : super(totalDocs, limit, totalPages, page, pagingCounter, hasPrevPage,
            hasNextPage, prevPage, nextPage);

  ExploreResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    docs = (json['docs'] as List).map((item) {
      return ExploreModel.fromJson(item);
    }).toList();
  }

  static ExploreResponse clearPagin() {
    return ExploreResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}
