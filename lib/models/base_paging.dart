class BaseBaging {
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;

  BaseBaging(
      this.totalDocs,
      this.limit,
      this.totalPages,
      this.page,
      this.pagingCounter,
      this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage);

  BaseBaging.fromJson(Map<String, dynamic> json)
      : totalDocs = json['totalDocs'],
        limit = json['limit'],
        totalPages = json['totalPages'],
        page = json['page'],
        pagingCounter = json['pagingCounter'],
        hasPrevPage = json['hasPrevPage'],
        hasNextPage = json['hasNextPage'],
        prevPage = json['prevPage'],
        nextPage = json['nextPage'];

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
      };

  static BaseBaging clearPagin() {
    return BaseBaging(0, 0, 0, 0, 0, false, false, 0, 0);
  }
}
