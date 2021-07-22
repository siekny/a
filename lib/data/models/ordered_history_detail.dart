class OrderedHistoryDetail {
  int code;
  String description;
  Data data;

  OrderedHistoryDetail({this.code, this.description, this.data});
  OrderedHistoryDetail.fromJson(Map<String, dynamic> json) {
    json['code'] = this.code;
    json['description'] = this.description;
    json['data'] = this.data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['data'] = this.data;

    return data;
  }
}

class Data {
  List<ListItems> listItems;
  List<ReceiptUploads> receiptUploads;

  Data({this.listItems, this.receiptUploads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list_items'] != null) {
      listItems = <ListItems>[];
      json['list_items'].forEach((v) {
        listItems.add(new ListItems.fromJson(v));
      });
    }
    if (json['receipt_uploads'] != null) {
      receiptUploads = <ReceiptUploads>[];
      json['receipt_uploads'].forEach((v) {
        receiptUploads.add(new ReceiptUploads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listItems != null) {
      data['list_items'] = this.listItems.map((v) => v.toJson()).toList();
    }
    if (this.receiptUploads != null) {
      data['receipt_uploads'] =
          this.receiptUploads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItems {
  String itemId;
  String productName;
  String productCode;
  String colorSize;
  String quantity;
  String arriveQuantity;
  String cancelQuantity;
  String express;
  String expressCode;
  String price;
  String amount;
  String thumbnail;

  ListItems(
      {this.itemId,
      this.productName,
      this.productCode,
      this.colorSize,
      this.quantity,
      this.arriveQuantity,
      this.cancelQuantity,
      this.express,
      this.expressCode,
      this.price,
      this.amount,
      this.thumbnail});

  ListItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    colorSize = json['color_size'];
    quantity = json['quantity'];
    arriveQuantity = json['arrive_quantity'];
    cancelQuantity = json['cancel_quantity'];
    express = json['express'];
    expressCode = json['express_code'];
    price = json['price'];
    amount = json['amount'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['color_size'] = this.colorSize;
    data['quantity'] = this.quantity;
    data['arrive_quantity'] = this.arriveQuantity;
    data['cancel_quantity'] = this.cancelQuantity;
    data['express'] = this.express;
    data['express_code'] = this.expressCode;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class ReceiptUploads {
  String receiptId;
  String image;
  bool remove;

  ReceiptUploads({this.receiptId, this.image, this.remove});

  ReceiptUploads.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    image = json['image'];
    remove = json['remove'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['image'] = this.image;
    data['remove'] = this.remove;
    return data;
  }
}

class AwaitingApproval {
  String supplyer;
  String supplyerThumbnail;
  List<ListItems> items;

  AwaitingApproval({this.supplyer, this.supplyerThumbnail, this.items});

  AwaitingApproval.fromJson(Map<String, dynamic> json) {
    supplyer = json['supplyer'];
    supplyerThumbnail = json['supplyer_thumbnail'];
    if (json['items'] != null) {
      items = <ListItems>[];
      json['items'].forEach((v) {
        items.add(new ListItems.fromJson(v));
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
