import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/wishlist.dart';
import 'package:htb_mobile/services/wishlist_service.dart';

class WishListCubit extends Cubit<Wishlist> {
  final _service = WishListService();

  WishListCubit() : super(null);

  void getWishLists() async => emit(await _service.getWishLists());

  void removeOneWishlist(String wishlistId) async {
    await _service.removeOneWishlist(wishlistId);
    getWishLists();
  }

  void removeWishlishInDetail(String wishlishId, String productCode) async {
    await _service.removeOneWishlist(wishlishId);
    getWishLists();
    // ProductDetailCubit().getProductDetail(productCode);
  }

  void addWishlist(wishlist, String productCode) async {
    await _service.addwishlist(wishlist);
    getWishLists();
    // ProductDetailCubit().getProductDetail(productCode);
  }
}
