import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/product_detail.dart';
import 'package:htb_mobile/data/repository.dart';
import 'package:htb_mobile/services/wishlist_service.dart';

class ProductDetailCubit extends Cubit<ProductDetail> {
  final Repository _repository = Repository();
  final _service = WishListService();
  // Wishlist _wishList;
  String _wishlistId;
  bool _isFavored = false;

  ProductDetailCubit() : super(null);

  void getProductDetail(String id) async {
    print('product-id $id');
    try {
      final responses = await Future.wait(
          [_repository.getProductInfo(id), _repository.getProductConfig(id)]);

      final productInfo = responses[0];
      final productConfig = responses[1];

      var productData = productInfo["Result"]["Item"];
      var configData = productConfig["Result"]["Configuration"];
      var price, regularPrice, rating = 0.0;

      var description = productInfo["Result"]["Description"];

      if ((configData["Current"]["Price"]["Min"] != null) &&
          (configData["Current"]["Price"]["Max"] != null)) {
        price = configData["Current"]["Price"]["Min"];
      } else {
        price = configData["Current"]["Price"]["Base"];
      }
      if (configData["Current"]["OldPrice"] != null) {
        regularPrice = configData["Current"]["OldPrice"]["Base"];
      }

      var vendor = productInfo["Result"]["Item"]["Features"] as List<dynamic>;
      if (vendor.isNotEmpty) {
        var ven = vendor.where((element) => element["Id"] == 'rating');

        if (ven.isNotEmpty) {
          rating = double.parse(ven.first["Value"].toString());
        }
      }

      // wishlist
      await _service.getWishLists().then((value) {
        print('_wishlist ${value?.listCarts} ${productData["Id"]}');
        if (value == null || value.listCarts.isEmpty) {
          _wishlistId = null;
          _isFavored = false;
        } else {
          for (var i = 0; i < value?.listCarts?.length; i++) {
            for (var j = 0; j < value?.listCarts[i]?.items?.length; j++) {
              if (value?.listCarts[i]?.items[j]?.productCode ==
                  productData["Id"]) {
                print(
                    ('code_matched ${value?.listCarts[i]?.items[j]?.productCode}'));
                _wishlistId = value?.listCarts[i]?.items[j]?.whistlistId;
                _isFavored = true;
              }
            }
          }
        }
      });

      ProductDetail product = ProductDetail(
          title: productData["Title"],
          id: productData["Id"],
          videos: productData["Videos"],
          price: price,
          supplyer: productData["Vendor"]["DisplayName"],
          product_url: productData["ExternalItemUrl"],
          thumnail_url: productData["Pictures"][0]["Url"],
          description: description,
          pictures: productData["Pictures"],
          properties: productData["Configurators"]["Property"],
          oldPrice: regularPrice,
          vendor: rating,
          availability: productData["Availability"]["Value"],
          wishlistId: _wishlistId,
          isFavored: _isFavored);

      emit(product);
    } catch (e) {
      print('error $e');
    }
  }

  void removeWishlishInDetail(String wishlishId, String productCode) async {
    await _service.removeOneWishlist(wishlishId);
    getProductDetail(productCode);
  }

  void clearProductDetail() => emit(null);

  Future<int> addCart(String token, ProductDetail product) async {
    return _repository.addCart(token, product);
    // var carts = responses["data"]["list_carts"] as List<dynamic>;

    // var lists = carts.map((cart)=>CartResponse.fromJson(cart)).toList();

    // emit(CartLoaded(carts: lists));
  }
}
