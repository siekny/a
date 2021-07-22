class SearchResult {
  String errorCode;
  SubErrorCode subErrorCode;
  String requestId;
  Result result;

  SearchResult(
      {this.errorCode, this.subErrorCode, this.requestId, this.result});

  SearchResult.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    subErrorCode = json['SubErrorCode'] != null
        ? new SubErrorCode.fromJson(json['SubErrorCode'])
        : null;
    requestId = json['RequestId'];
    result =
        json['Result'] != null ? new Result.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    if (this.subErrorCode != null) {
      data['SubErrorCode'] = this.subErrorCode.toJson();
    }
    data['RequestId'] = this.requestId;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class SubErrorCode {
  // SubErrorCode({});

  SubErrorCode.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Result {
  Items items;
  String provider;
  String searchMethod;
  String currentSort;
  int currentFrameSize;
  int maximumPageCount;

  Result(
      {this.items,
      this.provider,
      this.searchMethod,
      this.currentSort,
      this.currentFrameSize,
      this.maximumPageCount});

  Result.fromJson(Map<String, dynamic> json) {
    items = json['Items'] != null ? new Items.fromJson(json['Items']) : null;
    provider = json['Provider'];
    searchMethod = json['SearchMethod'];
    currentSort = json['CurrentSort'];
    currentFrameSize = json['CurrentFrameSize'];
    maximumPageCount = json['MaximumPageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['Items'] = this.items.toJson();
    }
    data['Provider'] = this.provider;
    data['SearchMethod'] = this.searchMethod;
    data['CurrentSort'] = this.currentSort;
    data['CurrentFrameSize'] = this.currentFrameSize;
    data['MaximumPageCount'] = this.maximumPageCount;
    return data;
  }
}

class Items {
  List<Content> content;
  int totalCount;

  Items({this.content, this.totalCount});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      content = <Content>[];
      json['Content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['Content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class Content {
  String id;
  String errorCode;
  bool hasError;
  String providerType;
  String updatedTime;
  String title;
  // String originalTitle;
  // String categoryId;
  // String externalCategoryId;
  // String vendorId;
  // String vendorName;
  int vendorScore;
  // String brandId;
  // String brandName;
  // String taobaoItemUrl;
  // String externalItemUrl;
  String mainPictureUrl;
  // String stuffStatus;
  // int volume;
  Price price;
  PromotionPrice promotionPrice;
  // List<Pictures> pictures;
  // Location location;
  // List<String> features;
  // List<FeaturedValues> featuredValues;
  // bool isSellAllowed;
  // SubErrorCode physicalParameters;
  // bool isFiltered;
  // PriceWithoutDelivery promotionPrice;
  // List<PromotionPricePercent> promotionPricePercent;

  Content({
    this.id,
    this.errorCode,
    this.hasError,
    this.providerType,
    this.updatedTime,
    this.title,
    // this.originalTitle,
    // this.categoryId,
    // this.externalCategoryId,
    // this.vendorId,
    // this.vendorName,
    this.vendorScore,
    // this.brandId,
    // this.brandName,
    // this.taobaoItemUrl,
    // this.externalItemUrl,
    this.mainPictureUrl,
    // this.stuffStatus,
    // this.volume,
    // this.price,
    // this.pictures,
    // this.location,
    // this.features,
    // this.featuredValues,
    // this.isSellAllowed,
    // this.physicalParameters,
    // this.isFiltered,
    this.promotionPrice,
    // this.promotionPricePercent
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    errorCode = json['ErrorCode'];
    hasError = json['HasError'];
    providerType = json['ProviderType'];
    updatedTime = json['UpdatedTime'];
    title = json['Title'];
    // originalTitle = json['OriginalTitle'];
    // categoryId = json['CategoryId'];
    // externalCategoryId = json['ExternalCategoryId'];
    // vendorId = json['VendorId'];
    // vendorName = json['VendorName'];
    vendorScore = json['VendorScore'];
    // brandId = json['BrandId'];
    // brandName = json['BrandName'];
    // taobaoItemUrl = json['TaobaoItemUrl'];
    // externalItemUrl = json['ExternalItemUrl'];
    mainPictureUrl = json['MainPictureUrl'];
    // stuffStatus = json['StuffStatus'];
    // volume = json['Volume'];
    price = json['Price'] != null ? new Price.fromJson(json['Price']) : null;
    // if (json['Pictures'] != null) {
    //   pictures = new List<Pictures>();
    //   json['Pictures'].forEach((v) {
    //     pictures.add(new Pictures.fromJson(v));
    //   });
    // }
    // location = json['Location'] != null
    //     ? new Location.fromJson(json['Location'])
    //     : null;
    // features = json['Features'].cast<String>();
    // if (json['FeaturedValues'] != null) {
    //   featuredValues = new List<FeaturedValues>();
    //   json['FeaturedValues'].forEach((v) {
    //     featuredValues.add(new FeaturedValues.fromJson(v));
    //   });
    // }
    // isSellAllowed = json['IsSellAllowed'];
    // physicalParameters = json['PhysicalParameters'] != null
    //     ? new SubErrorCode.fromJson(json['PhysicalParameters'])
    //     : null;
    // isFiltered = json['IsFiltered'];
    promotionPrice = json['PromotionPrice'] != null
        ? new PromotionPrice.fromJson(json['PromotionPrice'])
        : null;
    // if (json['PromotionPricePercent'] != null) {
    //   promotionPricePercent = new List<PromotionPricePercent>();
    //   json['PromotionPricePercent'].forEach((v) {
    //     promotionPricePercent.add(new PromotionPricePercent.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ErrorCode'] = this.errorCode;
    data['HasError'] = this.hasError;
    data['ProviderType'] = this.providerType;
    data['UpdatedTime'] = this.updatedTime;
    data['Title'] = this.title;
    // data['OriginalTitle'] = this.originalTitle;
    // data['CategoryId'] = this.categoryId;
    // data['ExternalCategoryId'] = this.externalCategoryId;
    // data['VendorId'] = this.vendorId;
    // data['VendorName'] = this.vendorName;
    data['VendorScore'] = this.vendorScore;
    // data['BrandId'] = this.brandId;
    // data['BrandName'] = this.brandName;
    // data['TaobaoItemUrl'] = this.taobaoItemUrl;
    // data['ExternalItemUrl'] = this.externalItemUrl;
    data['MainPictureUrl'] = this.mainPictureUrl;
    // data['StuffStatus'] = this.stuffStatus;
    // data['Volume'] = this.volume;
    if (this.price != null) {
      data['Price'] = this.price.toJson();
    }
    // if (this.pictures != null) {
    //   data['Pictures'] = this.pictures.map((v) => v.toJson()).toList();
    // }
    // if (this.location != null) {
    //   data['Location'] = this.location.toJson();
    // }
    // data['Features'] = this.features;
    // if (this.featuredValues != null) {
    //   data['FeaturedValues'] =
    //       this.featuredValues.map((v) => v.toJson()).toList();
    // }
    // data['IsSellAllowed'] = this.isSellAllowed;
    // if (this.physicalParameters != null) {
    //   data['PhysicalParameters'] = this.physicalParameters.toJson();
    // }
    // data['IsFiltered'] = this.isFiltered;
    if (this.promotionPrice != null) {
      data['PromotionPrice'] = this.promotionPrice.toJson();
    }
    // if (this.promotionPricePercent != null) {
    //   data['PromotionPricePercent'] =
    //       this.promotionPricePercent.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Price {
  double originalPrice;
  double marginPrice;
  String originalCurrencyCode;
  ConvertedPriceList convertedPriceList;
  String convertedPrice;
  String convertedPriceWithoutSign;
  String currencySign;
  String currencyName;
  bool isDeliverable;
  // DeliveryPrice deliveryPrice;
  // DeliveryPrice oneItemDeliveryPrice;
  // PriceWithoutDelivery priceWithoutDelivery;
  // PriceWithoutDelivery oneItemPriceWithoutDelivery;

  Price({
    this.originalPrice,
    this.marginPrice,
    this.originalCurrencyCode,
    this.convertedPriceList,
    this.convertedPrice,
    this.convertedPriceWithoutSign,
    this.currencySign,
    this.currencyName,
    this.isDeliverable,
    // this.deliveryPrice,
    // this.oneItemDeliveryPrice,
    // this.priceWithoutDelivery,
    // this.oneItemPriceWithoutDelivery
  });

  Price.fromJson(Map<String, dynamic> json) {
    originalPrice = json['OriginalPrice'];
    marginPrice = json['MarginPrice'];
    originalCurrencyCode = json['OriginalCurrencyCode'];
    convertedPriceList = json['ConvertedPriceList'] != null
        ? new ConvertedPriceList.fromJson(json['ConvertedPriceList'])
        : null;
    convertedPrice = json['ConvertedPrice'];
    convertedPriceWithoutSign = json['ConvertedPriceWithoutSign'];
    currencySign = json['CurrencySign'];
    currencyName = json['CurrencyName'];
    isDeliverable = json['IsDeliverable'];
    // deliveryPrice = json['DeliveryPrice'] != null
    //     ? new DeliveryPrice.fromJson(json['DeliveryPrice'])
    //     : null;
    // oneItemDeliveryPrice = json['OneItemDeliveryPrice'] != null
    //     ? new DeliveryPrice.fromJson(json['OneItemDeliveryPrice'])
    //     : null;
    // priceWithoutDelivery = json['PriceWithoutDelivery'] != null
    //     ? new PriceWithoutDelivery.fromJson(json['PriceWithoutDelivery'])
    //     : null;
    // oneItemPriceWithoutDelivery = json['OneItemPriceWithoutDelivery'] != null
    //     ? new PriceWithoutDelivery.fromJson(json['OneItemPriceWithoutDelivery'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OriginalPrice'] = this.originalPrice;
    data['MarginPrice'] = this.marginPrice;
    data['OriginalCurrencyCode'] = this.originalCurrencyCode;
    if (this.convertedPriceList != null) {
      data['ConvertedPriceList'] = this.convertedPriceList.toJson();
    }
    data['ConvertedPrice'] = this.convertedPrice;
    data['ConvertedPriceWithoutSign'] = this.convertedPriceWithoutSign;
    data['CurrencySign'] = this.currencySign;
    data['CurrencyName'] = this.currencyName;
    data['IsDeliverable'] = this.isDeliverable;
    // if (this.deliveryPrice != null) {
    //   data['DeliveryPrice'] = this.deliveryPrice.toJson();
    // }
    // if (this.oneItemDeliveryPrice != null) {
    //   data['OneItemDeliveryPrice'] = this.oneItemDeliveryPrice.toJson();
    // }
    // if (this.priceWithoutDelivery != null) {
    //   data['PriceWithoutDelivery'] = this.priceWithoutDelivery.toJson();
    // }
    // if (this.oneItemPriceWithoutDelivery != null) {
    //   data['OneItemPriceWithoutDelivery'] =
    //       this.oneItemPriceWithoutDelivery.toJson();
    // }
    return data;
  }
}

class ConvertedPriceList {
  Internal internal;
  List<Internal> displayedMoneys;

  ConvertedPriceList({this.internal, this.displayedMoneys});

  ConvertedPriceList.fromJson(Map<String, dynamic> json) {
    internal = json['Internal'] != null
        ? new Internal.fromJson(json['Internal'])
        : null;
    if (json['DisplayedMoneys'] != null) {
      displayedMoneys = <Internal>[];
      json['DisplayedMoneys'].forEach((v) {
        displayedMoneys.add(new Internal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.internal != null) {
      data['Internal'] = this.internal.toJson();
    }
    if (this.displayedMoneys != null) {
      data['DisplayedMoneys'] =
          this.displayedMoneys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromotionPrice {
  double originalPrice;
  double marginPrice;
  String originalCurrencyCode;
  ConvertedPriceList convertedPriceList;

  PromotionPrice(
      {this.originalPrice,
      this.marginPrice,
      this.originalCurrencyCode,
      this.convertedPriceList});

  PromotionPrice.fromJson(Map<String, dynamic> json) {
    originalPrice = json['OriginalPrice'];
    marginPrice = json['MarginPrice'];
    originalCurrencyCode = json['OriginalCurrencyCode'];
    convertedPriceList = json['ConvertedPriceList'] != null
        ? new ConvertedPriceList.fromJson(json['ConvertedPriceList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OriginalPrice'] = this.originalPrice;
    data['MarginPrice'] = this.marginPrice;
    data['OriginalCurrencyCode'] = this.originalCurrencyCode;
    if (this.convertedPriceList != null) {
      data['ConvertedPriceList'] = this.convertedPriceList.toJson();
    }
    return data;
  }
}

// class DeliveryPrice {
//   double originalPrice;
//   double marginPrice;
//   String originalCurrencyCode;
//   // ConvertedPriceList convertedPriceList;

//   DeliveryPrice(
//       {this.originalPrice,
//       this.marginPrice,
//       this.originalCurrencyCode,
//       // this.convertedPriceList
//       });

//   DeliveryPrice.fromJson(Map<String, dynamic> json) {
//     originalPrice = json['OriginalPrice'];
//     marginPrice = json['MarginPrice'];
//     originalCurrencyCode = json['OriginalCurrencyCode'];
//     // convertedPriceList = json['ConvertedPriceList'] != null
//     //     ? new ConvertedPriceList.fromJson(json['ConvertedPriceList'])
//     //     : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['OriginalPrice'] = this.originalPrice;
//     data['MarginPrice'] = this.marginPrice;
//     data['OriginalCurrencyCode'] = this.originalCurrencyCode;
//     // if (this.convertedPriceList != null) {
//     //   data['ConvertedPriceList'] = this.convertedPriceList.toJson();
//     // }
//     return data;
//   }
// }

class Internal {
  double price;
  String sign;
  String code;

  Internal({this.price, this.sign, this.code});

  Internal.fromJson(Map<String, dynamic> json) {
    price = json['Price'];
    sign = json['Sign'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Price'] = this.price;
    data['Sign'] = this.sign;
    data['Code'] = this.code;
    return data;
  }
}

// class PriceWithoutDelivery {
//   double originalPrice;
//   double marginPrice;
//   String originalCurrencyCode;
//   ConvertedPriceList convertedPriceList;

//   PriceWithoutDelivery(
//       {this.originalPrice,
//       this.marginPrice,
//       this.originalCurrencyCode,
//       this.convertedPriceList});

//   PriceWithoutDelivery.fromJson(Map<String, dynamic> json) {
//     originalPrice = json['OriginalPrice'];
//     marginPrice = json['MarginPrice'];
//     originalCurrencyCode = json['OriginalCurrencyCode'];
//     convertedPriceList = json['ConvertedPriceList'] != null
//         ? new ConvertedPriceList.fromJson(json['ConvertedPriceList'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['OriginalPrice'] = this.originalPrice;
//     data['MarginPrice'] = this.marginPrice;
//     data['OriginalCurrencyCode'] = this.originalCurrencyCode;
//     if (this.convertedPriceList != null) {
//       data['ConvertedPriceList'] = this.convertedPriceList.toJson();
//     }
//     return data;
//   }
// }

// class Pictures {
//   String url;
//   Small small;
//   Small medium;
//   Small large;
//   bool isMain;

//   Pictures({this.url, this.small, this.medium, this.large, this.isMain});

//   Pictures.fromJson(Map<String, dynamic> json) {
//     url = json['Url'];
//     small = json['Small'] != null ? new Small.fromJson(json['Small']) : null;
//     medium = json['Medium'] != null ? new Small.fromJson(json['Medium']) : null;
//     large = json['Large'] != null ? new Small.fromJson(json['Large']) : null;
//     isMain = json['IsMain'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Url'] = this.url;
//     if (this.small != null) {
//       data['Small'] = this.small.toJson();
//     }
//     if (this.medium != null) {
//       data['Medium'] = this.medium.toJson();
//     }
//     if (this.large != null) {
//       data['Large'] = this.large.toJson();
//     }
//     data['IsMain'] = this.isMain;
//     return data;
//   }
// }

// class Small {
//   String url;
//   int width;
//   int height;

//   Small({this.url, this.width, this.height});

//   Small.fromJson(Map<String, dynamic> json) {
//     url = json['Url'];
//     width = json['Width'];
//     height = json['Height'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Url'] = this.url;
//     data['Width'] = this.width;
//     data['Height'] = this.height;
//     return data;
//   }
// }

// class Location {
//   String city;
//   String state;

//   Location({this.city, this.state});

//   Location.fromJson(Map<String, dynamic> json) {
//     city = json['City'];
//     state = json['State'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['City'] = this.city;
//     data['State'] = this.state;
//     return data;
//   }
// }

// class FeaturedValues {
//   String name;
//   String value;

//   FeaturedValues({this.name, this.value});

//   FeaturedValues.fromJson(Map<String, dynamic> json) {
//     name = json['Name'];
//     value = json['Value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Name'] = this.name;
//     data['Value'] = this.value;
//     return data;
//   }
// }

// class PromotionPricePercent {
//   String currencyCode;
//   double percent;

//   PromotionPricePercent({this.currencyCode, this.percent});

//   PromotionPricePercent.fromJson(Map<String, dynamic> json) {
//     currencyCode = json['CurrencyCode'];
//     percent = json['Percent'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['CurrencyCode'] = this.currencyCode;
//     data['Percent'] = this.percent;
//     return data;
//   }
// }
