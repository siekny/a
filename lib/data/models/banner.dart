class BannerOT {
  String errorCode;
  SubErrorCode subErrorCode;
  String requestId;
  Result result;

  BannerOT({this.errorCode, this.subErrorCode, this.requestId, this.result});

  BannerOT.fromJson(Map<String, dynamic> json) {
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
  List<Content> content;

  Result({this.content});

  Result.fromJson(Map<String, dynamic> json) {
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
  String name;
  String pictureUrl;
  String actionType;
  String actionParameter;

  Content({this.name, this.pictureUrl, this.actionType, this.actionParameter});

  Content.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    pictureUrl = json['PictureUrl'];
    actionType = json['ActionType'];
    actionParameter = json['ActionParameter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['PictureUrl'] = this.pictureUrl;
    data['ActionType'] = this.actionType;
    data['ActionParameter'] = this.actionParameter;
    return data;
  }
}
