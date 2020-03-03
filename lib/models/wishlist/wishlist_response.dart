import '../../models/base_paging.dart';
import '../../models/wishlist/wishlist_model.dart';

class WishlistResponse extends BaseBaging {
  List<WishlistModel> docs;

  WishlistResponse(this.docs, totalDocs, limit, totalPages, page, pagingCounter,
      hasPrevPage, hasNextPage, prevPage, nextPage)
      : super(totalDocs, limit, totalPages, page, pagingCounter, hasPrevPage,
            hasNextPage, prevPage, nextPage);

  WishlistResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    docs = (json['docs'] as List).map((item) {
      return WishlistModel.fromJson(item);
    }).toList();
  }

  static WishlistResponse clearPagin() {
    return WishlistResponse([], 0, 0, 0, 0, 0, false, false, 0, 0);
  }
}
