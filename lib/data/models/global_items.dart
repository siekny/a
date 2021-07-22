class GlobalItems {
  String errorCode;
  SubErrorCode subErrorCode;
  String requestId;
  Result result;

  GlobalItems({this.errorCode, this.subErrorCode, this.requestId, this.result});

  GlobalItems.fromJson(Map<String, dynamic> json) {
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
  SearchProperties searchProperties;
  Categories availableSearchMethods;
  SubCategories subCategories;

  Result(
      {this.items,
      this.searchProperties,
      this.availableSearchMethods,
      this.subCategories});

  Result.fromJson(Map<String, dynamic> json) {
    items = json['Items'] != null ? new Items.fromJson(json['Items']) : null;
    searchProperties = json['SearchProperties'] != null
        ? new SearchProperties.fromJson(json['SearchProperties'])
        : null;
    availableSearchMethods = json['AvailableSearchMethods'] != null
        ? new Categories.fromJson(json['AvailableSearchMethods'])
        : null;
    subCategories = json['SubCategories'] != null
        ? new SubCategories.fromJson(json['SubCategories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['Items'] = this.items.toJson();
    }
    if (this.searchProperties != null) {
      data['SearchProperties'] = this.searchProperties.toJson();
    }
    if (this.availableSearchMethods != null) {
      data['AvailableSearchMethods'] = this.availableSearchMethods.toJson();
    }
    if (this.subCategories != null) {
      data['SubCategories'] = this.subCategories.toJson();
    }
    return data;
  }
}

class SubCategories {
  List<SubContent> content;

  SubCategories({this.content});

  SubCategories.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      content = <SubContent>[];
      json['Content'].forEach((v) {
        content.add(new SubContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['Content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubContent {
  String id;
  String providerType;
  String updatedTime;
  bool isHidden;
  bool isVirtual;
  String externalId;
  String name;
  bool isParent;
  String parentId;
  bool isInternal;

  SubContent(
      {this.id,
      this.providerType,
      this.updatedTime,
      this.isHidden,
      this.isVirtual,
      this.externalId,
      this.name,
      this.isParent,
      this.parentId,
      this.isInternal});

  SubContent.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    providerType = json['ProviderType'];
    updatedTime = json['UpdatedTime'];
    isHidden = json['IsHidden'];
    isVirtual = json['IsVirtual'];
    externalId = json['ExternalId'];
    name = json['Name'];
    isParent = json['IsParent'];
    parentId = json['ParentId'];
    isInternal = json['IsInternal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProviderType'] = this.providerType;
    data['UpdatedTime'] = this.updatedTime;
    data['IsHidden'] = this.isHidden;
    data['IsVirtual'] = this.isVirtual;
    data['ExternalId'] = this.externalId;
    data['Name'] = this.name;
    data['IsParent'] = this.isParent;
    data['ParentId'] = this.parentId;
    data['IsInternal'] = this.isInternal;
    return data;
  }
}

class AvailableSearchMethods {
  List<ContentSM> content;

  AvailableSearchMethods({this.content});

  AvailableSearchMethods.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      content = <ContentSM>[];
      json['Content'].forEach((v) {
        content.add(new ContentSM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['Content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentSM {
  String provider;
  String searchMethod;
  String displayName;
  int optimalFrameSize;
  int maximumFrameSize;
  int maximumItemsCount;
  List<AvailableSorts> availableSorts;
  bool text;
  bool category;
  bool vendor;
  bool vendorLocation;
  bool brand;
  bool configurators;
  String multipleConfiguratorLogic;
  bool priceRange;
  bool vendorRatingRange;
  int minVendorRating;
  int maxVendorRating;
  bool volumeRange;
  String volumeRangeLogic;
  bool stuffStatus;
  List<Features> features;
  bool firstLotRange;
  bool enableMorphologyPreprocess;
  String module;
  bool allowSearchWithoutParameters;

  ContentSM(
      {this.provider,
      this.searchMethod,
      this.displayName,
      this.optimalFrameSize,
      this.maximumFrameSize,
      this.maximumItemsCount,
      this.availableSorts,
      this.text,
      this.category,
      this.vendor,
      this.vendorLocation,
      this.brand,
      this.configurators,
      this.multipleConfiguratorLogic,
      this.priceRange,
      this.vendorRatingRange,
      this.minVendorRating,
      this.maxVendorRating,
      this.volumeRange,
      this.volumeRangeLogic,
      this.stuffStatus,
      this.features,
      this.firstLotRange,
      this.enableMorphologyPreprocess,
      this.module,
      this.allowSearchWithoutParameters});

  ContentSM.fromJson(Map<String, dynamic> json) {
    provider = json['Provider'];
    searchMethod = json['SearchMethod'];
    displayName = json['DisplayName'];
    optimalFrameSize = json['OptimalFrameSize'];
    maximumFrameSize = json['MaximumFrameSize'];
    maximumItemsCount = json['MaximumItemsCount'];
    if (json['AvailableSorts'] != null) {
      availableSorts = <AvailableSorts>[];
      json['AvailableSorts'].forEach((v) {
        availableSorts.add(new AvailableSorts.fromJson(v));
      });
    }
    text = json['Text'];
    category = json['Category'];
    vendor = json['Vendor'];
    vendorLocation = json['VendorLocation'];
    brand = json['Brand'];
    configurators = json['Configurators'];
    multipleConfiguratorLogic = json['MultipleConfiguratorLogic'];
    priceRange = json['PriceRange'];
    vendorRatingRange = json['VendorRatingRange'];
    minVendorRating = json['MinVendorRating'];
    maxVendorRating = json['MaxVendorRating'];
    volumeRange = json['VolumeRange'];
    volumeRangeLogic = json['VolumeRangeLogic'];
    stuffStatus = json['StuffStatus'];
    if (json['Features'] != null) {
      features = <Features>[];
      json['Features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
    firstLotRange = json['FirstLotRange'];
    enableMorphologyPreprocess = json['EnableMorphologyPreprocess'];
    module = json['Module'];
    allowSearchWithoutParameters = json['AllowSearchWithoutParameters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Provider'] = this.provider;
    data['SearchMethod'] = this.searchMethod;
    data['DisplayName'] = this.displayName;
    data['OptimalFrameSize'] = this.optimalFrameSize;
    data['MaximumFrameSize'] = this.maximumFrameSize;
    data['MaximumItemsCount'] = this.maximumItemsCount;
    if (this.availableSorts != null) {
      data['AvailableSorts'] =
          this.availableSorts.map((v) => v.toJson()).toList();
    }
    data['Text'] = this.text;
    data['Category'] = this.category;
    data['Vendor'] = this.vendor;
    data['VendorLocation'] = this.vendorLocation;
    data['Brand'] = this.brand;
    data['Configurators'] = this.configurators;
    data['MultipleConfiguratorLogic'] = this.multipleConfiguratorLogic;
    data['PriceRange'] = this.priceRange;
    data['VendorRatingRange'] = this.vendorRatingRange;
    data['MinVendorRating'] = this.minVendorRating;
    data['MaxVendorRating'] = this.maxVendorRating;
    data['VolumeRange'] = this.volumeRange;
    data['VolumeRangeLogic'] = this.volumeRangeLogic;
    data['StuffStatus'] = this.stuffStatus;
    if (this.features != null) {
      data['Features'] = this.features.map((v) => v.toJson()).toList();
    }
    data['FirstLotRange'] = this.firstLotRange;
    data['EnableMorphologyPreprocess'] = this.enableMorphologyPreprocess;
    data['Module'] = this.module;
    data['AllowSearchWithoutParameters'] = this.allowSearchWithoutParameters;
    return data;
  }
}

class AvailableSorts {
  String field;
  String direction;
  String displayName;

  AvailableSorts({this.field, this.direction, this.displayName});

  AvailableSorts.fromJson(Map<String, dynamic> json) {
    field = json['Field'];
    direction = json['Direction'];
    displayName = json['DisplayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Field'] = this.field;
    data['Direction'] = this.direction;
    data['DisplayName'] = this.displayName;
    return data;
  }
}

class Features {
  String name;
  bool canBeTrue;
  bool canBeFalse;
  String displayName;
  String displayNameForTrue;

  Features(
      {this.name,
      this.canBeTrue,
      this.canBeFalse,
      this.displayName,
      this.displayNameForTrue});

  Features.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    canBeTrue = json['CanBeTrue'];
    canBeFalse = json['CanBeFalse'];
    displayName = json['DisplayName'];
    displayNameForTrue = json['DisplayNameForTrue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['CanBeTrue'] = this.canBeTrue;
    data['CanBeFalse'] = this.canBeFalse;
    data['DisplayName'] = this.displayName;
    data['DisplayNameForTrue'] = this.displayNameForTrue;
    return data;
  }
}

class SearchProperties {
  List<ContentP> contentP;

  SearchProperties({this.contentP});

  SearchProperties.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      contentP = <ContentP>[];
      json['Content'].forEach((v) {
        contentP.add(new ContentP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentP != null) {
      data['Content'] = this.contentP.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentP {
  String id;
  String name;
  List<Values> values;

  ContentP({this.id, this.name, this.values});

  ContentP.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    if (json['Values'] != null) {
      values = <Values>[];
      json['Values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    if (this.values != null) {
      data['Values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String id;
  String name;
  int itemCount;

  Values({this.id, this.name, this.itemCount});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    itemCount = json['ItemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['ItemCount'] = this.itemCount;
    return data;
  }
}

////////////////////////////////////////////////
class Categories {
  String contentType;
  String categoryId;
  String itemRatingType;
  bool hasError;
  String name;
  int order;
  Resultc result;

  Categories(
      {this.contentType,
      this.categoryId,
      this.itemRatingType,
      this.hasError,
      this.name,
      this.order,
      this.result});

  Categories.fromJson(Map<String, dynamic> json) {
    contentType = json['ContentType'];
    categoryId = json['CategoryId'];
    itemRatingType = json['ItemRatingType'];
    hasError = json['HasError'];
    name = json['Name'];
    order = json['Order'];
    result =
        json['Result'] != null ? new Resultc.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ContentType'] = this.contentType;
    data['CategoryId'] = this.categoryId;
    data['ItemRatingType'] = this.itemRatingType;
    data['HasError'] = this.hasError;
    data['Name'] = this.name;
    data['Order'] = this.order;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class Resultc {
  List<Contentc> contentc;
  int totalCount;

  Resultc({this.contentc, this.totalCount});

  Resultc.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      contentc = <Contentc>[];
      json['Content'].forEach((v) {
        contentc.add(new Contentc.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentc != null) {
      data['Content'] = this.contentc.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class Contentc {
  String id;
  String providerType;
  bool isHidden;
  bool isVirtual;
  String externalId;
  String name;
  bool isParent;
  String parentId;
  bool isInternal;
  RootPath rootPath;
  String iconImageUrl;

  Contentc(
      {this.id,
      this.providerType,
      this.isHidden,
      this.isVirtual,
      this.externalId,
      this.name,
      this.isParent,
      this.parentId,
      this.isInternal,
      this.rootPath,
      this.iconImageUrl});

  Contentc.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    providerType = json['ProviderType'];
    isHidden = json['IsHidden'];
    isVirtual = json['IsVirtual'];
    externalId = json['ExternalId'];
    name = json['Name'];
    isParent = json['IsParent'];
    parentId = json['ParentId'];
    isInternal = json['IsInternal'];
    rootPath = json['RootPath'] != null
        ? new RootPath.fromJson(json['RootPath'])
        : null;
    iconImageUrl = json['IconImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProviderType'] = this.providerType;
    data['IsHidden'] = this.isHidden;
    data['IsVirtual'] = this.isVirtual;
    data['ExternalId'] = this.externalId;
    data['Name'] = this.name;
    data['IsParent'] = this.isParent;
    data['ParentId'] = this.parentId;
    data['IsInternal'] = this.isInternal;
    if (this.rootPath != null) {
      data['RootPath'] = this.rootPath.toJson();
    }
    data['IconImageUrl'] = this.iconImageUrl;
    return data;
  }
}

class RootPath {
  List<ContentRooPath> contentRooPath;

  RootPath({this.contentRooPath});

  RootPath.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      contentRooPath = <ContentRooPath>[];
      json['Content'].forEach((v) {
        contentRooPath.add(new ContentRooPath.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentRooPath != null) {
      data['Content'] = this.contentRooPath.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentRooPath {
  String id;
  String providerType;
  bool isHidden;
  bool isVirtual;
  String externalId;
  String name;
  bool isParent;
  bool isInternal;

  ContentRooPath(
      {this.id,
      this.providerType,
      this.isHidden,
      this.isVirtual,
      this.externalId,
      this.name,
      this.isParent,
      this.isInternal});

  ContentRooPath.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    providerType = json['ProviderType'];
    isHidden = json['IsHidden'];
    isVirtual = json['IsVirtual'];
    externalId = json['ExternalId'];
    name = json['Name'];
    isParent = json['IsParent'];
    isInternal = json['IsInternal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProviderType'] = this.providerType;
    data['IsHidden'] = this.isHidden;
    data['IsVirtual'] = this.isVirtual;
    data['ExternalId'] = this.externalId;
    data['Name'] = this.name;
    data['IsParent'] = this.isParent;
    data['IsInternal'] = this.isInternal;
    return data;
  }
}
//////////////////////////////////////////////////////////////

class Items {
  // String contentType;
  // String categoryId;
  // String itemRatingType;
  // bool hasError;
  // String name;
  // int order;
  Results results;

  Items(
      {
      // {this.contentType,
      // this.categoryId,
      // this.itemRatingType,
      // this.hasError,
      // this.name,
      // this.order,
      this.results});

  Items.fromJson(Map<String, dynamic> json) {
    // contentType = json['ContentType'];
    // categoryId = json['CategoryId'];
    // itemRatingType = json['ItemRatingType'];
    // hasError = json['HasError'];
    // name = json['Name'];
    // order = json['Order'];
    results =
        json['Items'] != null ? new Results.fromJson(json['Items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['ContentType'] = this.contentType;
    // data['CategoryId'] = this.categoryId;
    // data['ItemRatingType'] = this.itemRatingType;
    // data['HasError'] = this.hasError;
    // data['Name'] = this.name;
    // data['Order'] = this.order;
    if (this.results != null) {
      data['Items'] = this.results.toJson();
    }
    return data;
  }
}

class Results {
  List<Content> content;
  int totalCount;

  Results({this.content, this.totalCount});

  Results.fromJson(Map<String, dynamic> json) {
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
  bool isTitleManuallyTranslated;
  String originalTitle;
  String categoryId;
  String externalCategoryId;
  String vendorId;
  String vendorName;
  int vendorScore;
  String brandId;
  String brandName;
  String taobaoItemUrl;
  String externalItemUrl;
  String mainPictureUrl;
  String stuffStatus;
  int volume;
  Price price;
  PromotionPrice promotionPrice;
  // List<Pictures> pictures;
  Location location;
  List<String> features;
  // List<FeaturedValues> featuredValues;
  bool isSellAllowed;
  // PhysicalParameters physicalParameters;
  bool isFiltered;
  // PriceWithoutDelivery promotionPrice;
  // List<PromotionPricePercent> promotionPricePercent;
  // List<QuantityRanges> quantityRanges;

  Content({
    this.id,
    this.errorCode,
    this.hasError,
    this.providerType,
    this.updatedTime,
    this.title,
    this.isTitleManuallyTranslated,
    this.originalTitle,
    this.categoryId,
    this.externalCategoryId,
    this.vendorId,
    this.vendorName,
    this.vendorScore,
    this.brandId,
    this.brandName,
    this.taobaoItemUrl,
    this.externalItemUrl,
    this.mainPictureUrl,
    this.stuffStatus,
    this.volume,
    this.price,
    this.promotionPrice,
    // this.pictures,
    this.location,
    this.features,
    // this.featuredValues,
    this.isSellAllowed,
    // this.physicalParameters,
    this.isFiltered,
    // this.promotionPrice,
    // this.promotionPricePercent,
    // this.quantityRanges
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    errorCode = json['ErrorCode'];
    hasError = json['HasError'];
    providerType = json['ProviderType'];
    updatedTime = json['UpdatedTime'];
    title = json['Title'];
    isTitleManuallyTranslated = json['IsTitleManuallyTranslated'];
    originalTitle = json['OriginalTitle'];
    categoryId = json['CategoryId'];
    externalCategoryId = json['ExternalCategoryId'];
    vendorId = json['VendorId'];
    vendorName = json['VendorName'];
    vendorScore = json['VendorScore'];
    brandId = json['BrandId'];
    brandName = json['BrandName'];
    taobaoItemUrl = json['TaobaoItemUrl'];
    externalItemUrl = json['ExternalItemUrl'];
    mainPictureUrl = json['MainPictureUrl'];
    stuffStatus = json['StuffStatus'];
    volume = json['Volume'];
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
    //     ? new PhysicalParameters.fromJson(json['PhysicalParameters'])
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
    // if (json['QuantityRanges'] != null) {
    //   quantityRanges = new List<QuantityRanges>();
    //   json['QuantityRanges'].forEach((v) {
    //     quantityRanges.add(new QuantityRanges.fromJson(v));
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
    data['IsTitleManuallyTranslated'] = this.isTitleManuallyTranslated;
    data['OriginalTitle'] = this.originalTitle;
    data['CategoryId'] = this.categoryId;
    data['ExternalCategoryId'] = this.externalCategoryId;
    data['VendorId'] = this.vendorId;
    data['VendorName'] = this.vendorName;
    data['VendorScore'] = this.vendorScore;
    data['BrandId'] = this.brandId;
    data['BrandName'] = this.brandName;
    data['TaobaoItemUrl'] = this.taobaoItemUrl;
    data['ExternalItemUrl'] = this.externalItemUrl;
    data['MainPictureUrl'] = this.mainPictureUrl;
    data['StuffStatus'] = this.stuffStatus;
    data['Volume'] = this.volume;
    if (this.price != null) {
      data['Price'] = this.price.toJson();
    }
    if (this.promotionPrice != null) {
      data['PromotionPrice'] = this.price.toJson();
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
    // if (this.promotionPrice != null) {
    //   data['PromotionPrice'] = this.promotionPrice.toJson();
    // }
    // if (this.promotionPricePercent != null) {
    //   data['PromotionPricePercent'] =
    //       this.promotionPricePercent.map((v) => v.toJson()).toList();
    // }
    // if (this.quantityRanges != null) {
    //   data['QuantityRanges'] =
    //       this.quantityRanges.map((v) => v.toJson()).toList();
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

// class ConvertedPriceList {
//   Internal internal;
//   List<DisplayedMoneys> displayedMoneys;

//   ConvertedPriceList({this.internal, this.displayedMoneys});

//   ConvertedPriceList.fromJson(Map<String, dynamic> json) {
//     internal = json['Internal'] != null
//         ? new Internal.fromJson(json['Internal'])
//         : null;
//     if (json['DisplayedMoneys'] != null) {
//       displayedMoneys = new List<DisplayedMoneys>();
//       json['DisplayedMoneys'].forEach((v) {
//         displayedMoneys.add(new DisplayedMoneys.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.internal != null) {
//       data['Internal'] = this.internal.toJson();
//     }
//     if (this.displayedMoneys != null) {
//       data['DisplayedMoneys'] =
//           this.displayedMoneys.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class DisplayedMoneys {
  double price;
  String sign;
  String code;

  DisplayedMoneys({this.price, this.sign, this.code});

  DisplayedMoneys.fromJson(Map<String, dynamic> json) {
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

// class Internal {
//   double price;
//   String sign;
//   String code;

//   Internal({this.price, this.sign, this.code});

//   Internal.fromJson(Map<String, dynamic> json) {
//     price = json['Price'];
//     sign = json['Sign'];
//     code = json['Code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Price'] = this.price;
//     data['Sign'] = this.sign;
//     data['Code'] = this.code;
//     return data;
//   }
// }

// class DeliveryPrice {
//   double originalPrice;
//   double marginPrice;
//   String originalCurrencyCode;
//   ConvertedPriceList convertedPriceList;

//   DeliveryPrice(
//       {this.originalPrice,
//       this.marginPrice,
//       this.originalCurrencyCode,
//       this.convertedPriceList});

//   DeliveryPrice.fromJson(Map<String, dynamic> json) {
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

// class Internals {
//   int price;
//   String sign;
//   String code;

//   Internals({this.price, this.sign, this.code});

//   Internals.fromJson(Map<String, dynamic> json) {
//     price = json['Price'];
//     sign = json['Sign'];
//     code = json['Code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Price'] = this.price;
//     data['Sign'] = this.sign;
//     data['Code'] = this.code;
//     return data;
//   }
// }

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

class Location {
  String city;
  String state;

  Location({this.city, this.state});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['City'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['City'] = this.city;
    data['State'] = this.state;
    return data;
  }
}

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

// class PhysicalParameters {
//   double weight;
//   double length;
//   double width;
//   double height;

//   PhysicalParameters({this.weight, this.length, this.width, this.height});

//   PhysicalParameters.fromJson(Map<String, dynamic> json) {
//     weight = json['Weight'];
//     length = json['Length'];
//     width = json['Width'];
//     height = json['Height'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Weight'] = this.weight;
//     data['Length'] = this.length;
//     data['Width'] = this.width;
//     data['Height'] = this.height;
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

// class QuantityRanges {
//   int minQuantity;
//   Price price;

//   QuantityRanges({this.minQuantity, this.price});

//   QuantityRanges.fromJson(Map<String, dynamic> json) {
//     minQuantity = json['MinQuantity'];
//     price = json['Price'] != null ? new Price.fromJson(json['Price']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['MinQuantity'] = this.minQuantity;
//     if (this.price != null) {
//       data['Price'] = this.price.toJson();
//     }
//     return data;
//   }
// }

class Contents {
  String id;
  String errorCode;
  bool hasError;
  String providerType;
  String updatedTime;
  String title;
  bool isTitleManuallyTranslated;
  String originalTitle;
  String categoryId;
  String externalCategoryId;
  String vendorId;
  String vendorName;
  int vendorScore;
  String brandId;
  String brandName;
  String taobaoItemUrl;
  String externalItemUrl;
  String mainPictureUrl;
  String stuffStatus;
  int volume;
  Price price;
  // List<Pictures> pictures;
  Location location;
  List<String> features;
  // List<FeaturedValues> featuredValues;
  bool isSellAllowed;
  // PhysicalParameters physicalParameters;
  bool isFiltered;
  // PriceWithoutDelivery promotionPrice;
  // List<PromotionPricePercent> promotionPricePercent;
  // List<QuantityRanges> quantityRanges;

  Contents({
    this.id,
    this.errorCode,
    this.hasError,
    this.providerType,
    this.updatedTime,
    this.title,
    this.isTitleManuallyTranslated,
    this.originalTitle,
    this.categoryId,
    this.externalCategoryId,
    this.vendorId,
    this.vendorName,
    this.vendorScore,
    this.brandId,
    this.brandName,
    this.taobaoItemUrl,
    this.externalItemUrl,
    this.mainPictureUrl,
    this.stuffStatus,
    this.volume,
    this.price,
    // this.pictures,
    this.location,
    this.features,
    // this.featuredValues,
    this.isSellAllowed,
    // this.physicalParameters,
    this.isFiltered,
    // this.promotionPrice,
    // this.promotionPricePercent,
    // this.quantityRanges
  });

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    errorCode = json['ErrorCode'];
    hasError = json['HasError'];
    providerType = json['ProviderType'];
    updatedTime = json['UpdatedTime'];
    title = json['Title'];
    isTitleManuallyTranslated = json['IsTitleManuallyTranslated'];
    originalTitle = json['OriginalTitle'];
    categoryId = json['CategoryId'];
    externalCategoryId = json['ExternalCategoryId'];
    vendorId = json['VendorId'];
    vendorName = json['VendorName'];
    vendorScore = json['VendorScore'];
    brandId = json['BrandId'];
    brandName = json['BrandName'];
    taobaoItemUrl = json['TaobaoItemUrl'];
    externalItemUrl = json['ExternalItemUrl'];
    mainPictureUrl = json['MainPictureUrl'];
    stuffStatus = json['StuffStatus'];
    volume = json['Volume'];
    price = json['Price'] != null ? new Price.fromJson(json['Price']) : null;
    // if (json['Pictures'] != null) {
    //   pictures = new List<Pictures>();
    //   json['Pictures'].forEach((v) {
    //     pictures.add(new Pictures.fromJson(v));
    //   });
    // }
    location = json['Location'] != null
        ? new Location.fromJson(json['Location'])
        : null;
    features = json['Features'].cast<String>();
    // if (json['FeaturedValues'] != null) {
    //   featuredValues = new List<FeaturedValues>();
    //   json['FeaturedValues'].forEach((v) {
    //     featuredValues.add(new FeaturedValues.fromJson(v));
    //   });
    // }
    isSellAllowed = json['IsSellAllowed'];
    // physicalParameters = json['PhysicalParameters'] != null
    //     ? new PhysicalParameters.fromJson(json['PhysicalParameters'])
    //     : null;
    // isFiltered = json['IsFiltered'];
    // promotionPrice = json['PromotionPrice'] != null
    //     ? new PriceWithoutDelivery.fromJson(json['PromotionPrice'])
    //     : null;
    // if (json['PromotionPricePercent'] != null) {
    //   promotionPricePercent = new List<PromotionPricePercent>();
    //   json['PromotionPricePercent'].forEach((v) {
    //     promotionPricePercent.add(new PromotionPricePercent.fromJson(v));
    //   });
    // }
    // if (json['QuantityRanges'] != null) {
    //   quantityRanges = new List<QuantityRanges>();
    //   json['QuantityRanges'].forEach((v) {
    //     quantityRanges.add(new QuantityRanges.fromJson(v));
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
    data['IsTitleManuallyTranslated'] = this.isTitleManuallyTranslated;
    data['OriginalTitle'] = this.originalTitle;
    data['CategoryId'] = this.categoryId;
    data['ExternalCategoryId'] = this.externalCategoryId;
    data['VendorId'] = this.vendorId;
    data['VendorName'] = this.vendorName;
    data['VendorScore'] = this.vendorScore;
    data['BrandId'] = this.brandId;
    data['BrandName'] = this.brandName;
    data['TaobaoItemUrl'] = this.taobaoItemUrl;
    data['ExternalItemUrl'] = this.externalItemUrl;
    data['MainPictureUrl'] = this.mainPictureUrl;
    data['StuffStatus'] = this.stuffStatus;
    data['Volume'] = this.volume;
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
    // if (this.promotionPrice != null) {
    //   data['PromotionPrice'] = this.promotionPrice.toJson();
    // }
    // if (this.promotionPricePercent != null) {
    //   data['PromotionPricePercent'] =
    //       this.promotionPricePercent.map((v) => v.toJson()).toList();
    // }
    // if (this.quantityRanges != null) {
    //   data['QuantityRanges'] =
    //       this.quantityRanges.map((v) => v.toJson()).toList();
    // }
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

class ConvertedPriceList {
  Internal internal;
  List<DisplayedMoneys> displayedMoneys;

  ConvertedPriceList({this.internal});

  ConvertedPriceList.fromJson(Map<String, dynamic> json) {
    internal = json['Internal'] != null
        ? new Internal.fromJson(json['Internal'])
        : null;
    if (json['DisplayedMoneys'] != null) {
      displayedMoneys = new List<DisplayedMoneys>();
      json['DisplayedMoneys'].forEach((v) {
        displayedMoneys.add(new DisplayedMoneys.fromJson(v));
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

class Prices {
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

  Prices({
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

  Prices.fromJson(Map<String, dynamic> json) {
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

// class Picture {
//   String url;
//   Small small;
//   Small medium;
//   Small large;
//   bool isMain;

//   Picture({this.url, this.small, this.medium, this.large, this.isMain});

//   Picture.fromJson(Map<String, dynamic> json) {
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
