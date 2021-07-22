class SubCategory {
  String errorCode;
  SubErrorCode subErrorCode;
  String requestId;
  CategoryInfoList categoryInfoList;

  SubCategory(
      {this.errorCode,
      this.subErrorCode,
      this.requestId,
      this.categoryInfoList});

  SubCategory.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    subErrorCode = json['SubErrorCode'] != null
        ? new SubErrorCode.fromJson(json['SubErrorCode'])
        : null;
    requestId = json['RequestId'];
    categoryInfoList = json['CategoryInfoList'] != null
        ? new CategoryInfoList.fromJson(json['CategoryInfoList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    if (this.subErrorCode != null) {
      data['SubErrorCode'] = this.subErrorCode.toJson();
    }
    data['RequestId'] = this.requestId;
    if (this.categoryInfoList != null) {
      data['CategoryInfoList'] = this.categoryInfoList.toJson();
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

class CategoryInfoList {
  List<Content> content;

  CategoryInfoList({this.content});

  CategoryInfoList.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      content = <Content>[];
      json['Content'].forEach((v) {
        content.add(new Content.fromJson(v));
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

class Content {
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

  Content(
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

  Content.fromJson(Map<String, dynamic> json) {
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
