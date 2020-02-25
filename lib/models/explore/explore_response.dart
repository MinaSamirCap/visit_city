import 'package:visit_city/models/explore/explore_model.dart';

class ExploreResponse {
  List<ExploreModel> docs;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;

  ExploreResponse(
      this.docs,
      this.totalDocs,
      this.limit,
      this.totalPages,
      this.page,
      this.pagingCounter,
      this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage);

  ExploreResponse.fromJson(Map<String, dynamic> json)
      : totalDocs = json['totalDocs'],
        limit = json['limit'],
        totalPages = json['totalPages'],
        page = json['page'],
        pagingCounter = json['pagingCounter'],
        hasPrevPage = json['hasPrevPage'],
        hasNextPage = json['hasNextPage'],
        prevPage = json['prevPage'],
        nextPage = json['nextPage'],
        docs = (json['docs'] as List).map((item) {
          return ExploreModel.fromJson(item);
        }).toList();

  Map<String, dynamic> toJson() => {
        'totalDocs': totalDocs,
        'limit': limit,
        'totalPages': totalPages,
        'page': page,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
        'docs': docs.map((item) {
          return item.toJson();
        }).toList()
      };

  static ExploreResponse clearPagin() {
    return ExploreResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}
