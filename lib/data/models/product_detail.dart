class ProductDetail {
  final String id;
  final String title;
  final dynamic configurators;
  final double vendor;
  int quantity;
  final bool availability;
  final double price;
  String colorSize;
  final double amount;
  final double oldPrice;
  final String description;
  final String supplyer;
  final String product_url;
  final String thumnail_url;
  final String thumnail; //product in add to cart
  final String colorImageLink;
  final List<dynamic> properties;
  final List<dynamic> pictures;
  final dynamic videos;
  String wishlistId;
  bool isFavored;

  ProductDetail(
      {this.id,
      this.title,
      this.colorSize,
      this.configurators,
      this.availability,
      this.properties,
      this.pictures,
      this.vendor,
      this.product_url,
      this.thumnail_url,
      this.thumnail,
      this.colorImageLink,
      this.description,
      this.supplyer,
      this.quantity,
      this.price,
      this.amount,
      this.oldPrice,
      this.videos,
      this.wishlistId,
      this.isFavored});
}

// class ProductDetailWithWithlist {
//   final ProductDetail product;
//   final String wihslistId;
//   final bool isFavored;

//   ProductDetailWithWithlist({this.product, this.wihslistId, this.isFavored});
// }
