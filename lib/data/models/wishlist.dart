class Wishlist {
  List<ListCarts> listCarts;
  String countItem;

  Wishlist({this.listCarts, this.countItem});

  Wishlist.fromJson(Map<String, dynamic> json) {
    if (json['list_carts'] != null) {
      listCarts = <ListCarts>[];
      json['list_carts'].forEach((v) {
        listCarts.add(new ListCarts.fromJson(v));
      });
    }
    countItem = json['count_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCarts != null) {
      data['list_carts'] = this.listCarts.map((v) => v.toJson()).toList();
    }
    data['count_item'] = this.countItem;
    return data;
  }
}

class ListCarts {
  String supplyer;
  String supplyerThumbnail;
  List<Items> items;

  ListCarts({this.supplyer, this.supplyerThumbnail, this.items});

  ListCarts.fromJson(Map<String, dynamic> json) {
    supplyer = json['supplyer'];
    supplyerThumbnail = json['supplyer_thumbnail'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplyer'] = this.supplyer;
    data['supplyer_thumbnail'] = this.supplyerThumbnail;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String whistlistId;
  String productName;
  String productCode;
  String colorSize;
  String colorImageLink;
  String price;
  String thumbnail;
  String productUrl;

  Items(
      {this.whistlistId,
      this.productName,
      this.productCode,
      this.colorSize,
      this.colorImageLink,
      this.price,
      this.thumbnail,
      this.productUrl});

  Items.fromJson(Map<String, dynamic> json) {
    whistlistId = json['whistlist_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    colorSize = json['color_size'];
    colorImageLink = json['color_image_link'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    productUrl = json['product_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whistlist_id'] = this.whistlistId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['color_size'] = this.colorSize;
    data['color_image_link'] = this.colorImageLink;
    data['price'] = this.price;
    data['thumbnail'] = this.thumbnail;
    data['product_url'] = this.productUrl;
    return data;
  }
}
