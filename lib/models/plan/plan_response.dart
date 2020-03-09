import '../../models/base_paging.dart';
import '../../models/plan/plan_model.dart';

class PlanResponse extends BaseBaging {
  List<PlanModel> docs;

  PlanResponse(this.docs, totalDocs, limit, totalPages, page, pagingCounter,
      hasPrevPage, hasNextPage, prevPage, nextPage)
      : super(totalDocs, limit, totalPages, page, pagingCounter, hasPrevPage,
            hasNextPage, prevPage, nextPage);

  PlanResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    docs = (json['docs'] as List).map((item) {
      return PlanModel.fromJson(item);
    }).toList();
  }

  static PlanResponse clearPagin() {
    return PlanResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}