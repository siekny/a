class CartResponse {
  String supplier;
  String supplyThumbnail;
  List<dynamic> item;
  CartResponse({this.supplier, this.supplyThumbnail, this.item});

  CartResponse.fromJson(Map json)
      : supplier = json["supplyer"],
        supplyThumbnail = json["supplyer_thumbnail"],
        item = json["items"] as List<dynamic>;
}
