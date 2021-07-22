import 'package:htb_mobile/data/models/tracking_status.dart';

class Tracking {
  int code;
  String message;
  TrackingData data;

  Tracking({this.code, this.message, this.data});

  Tracking.fromJson(Map<String, dynamic> json) {
    code = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

class TrackingData {
  String itemId;
  String productName;
  String productCode;
  String colorSize;
  String thumbnail;
  List<TrackingStatus> trackingStatus;

  TrackingData(
      {this.itemId,
      this.productName,
      this.productCode,
      this.colorSize,
      this.thumbnail,
      this.trackingStatus});

  TrackingData.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    colorSize = json['color_size'];
    thumbnail = json['thumbnail'];
    if (json['tracking_status'] != null) {
      trackingStatus = <TrackingStatus>[];
      json['tracking_status'].forEach((v) {
        trackingStatus.add(new TrackingStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['color_size'] = this.colorSize;
    data['thumbnail'] = this.thumbnail;
    if (this.trackingStatus != null) {
      data['tracking_status'] =
          this.trackingStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
