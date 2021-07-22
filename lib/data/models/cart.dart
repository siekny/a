class Cart{
  String id;
  String productName;
  String code;
  String colorSize;
  String colorImageLink;
  String quantity;
  String price;
  String amount;
  String thumbnail;
  String productUrl;

  Cart({
    this.id,
    this.productName,
    this.code,
    this.colorSize,
    this.colorImageLink,
    this.quantity,
    this.price,
    this.amount,
    this.thumbnail,
    this.productUrl
  });

  Cart.fromJson(Map json) :
        id = json["cart_id"],
        productName = json["product_name"],
        code = json["product_code"],
        colorSize = json["color_size"],
        colorImageLink = json["color_image_link"],
        quantity = json["quantity"],
        price = json["price"],
        amount = json["amount"],
        thumbnail = json["thumbnail"],
        productUrl = json["product_url"];

}