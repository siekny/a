class Category {
  CategoryInfoList _categoryInfoList;

  Category({CategoryInfoList categoryInfoList}) {
    this._categoryInfoList = categoryInfoList;
  }

  CategoryInfoList get categoryInfoList => _categoryInfoList;
  set categoryInfoList(CategoryInfoList categoryInfoList) =>
      _categoryInfoList = categoryInfoList;

  Category.fromJson(Map<String, dynamic> json) {
    _categoryInfoList = json['CategoryInfoList'] != null
        ? new CategoryInfoList.fromJson(json['CategoryInfoList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._categoryInfoList != null) {
      data['CategoryInfoList'] = this._categoryInfoList.toJson();
    }
    return data;
  }
}

class CategoryInfoList {
  List<Content> _content;

  CategoryInfoList({List<Content> content}) {
    this._content = content;
  }

  List<Content> get content => _content;
  set content(List<Content> content) => _content = content;

  CategoryInfoList.fromJson(Map<String, dynamic> json) {
    if (json['Content'] != null) {
      _content = <Content>[];
      json['Content'].forEach((v) {
        _content.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._content != null) {
      data['Content'] = this._content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String _id;
  String _providerType;
  bool _isHidden;
  bool _isVirtual;
  String _externalId;
  String _name;
  bool _isParent;
  bool _isInternal;
  String _iconImageUrl;
  MetaData _metaData;

  Content(
      {String id,
      String providerType,
      bool isHidden,
      bool isVirtual,
      String externalId,
      String name,
      bool isParent,
      bool isInternal,
      String iconImageUrl,
      MetaData metaData}) {
    this._id = id;
    this._providerType = providerType;
    this._isHidden = isHidden;
    this._isVirtual = isVirtual;
    this._externalId = externalId;
    this._name = name;
    this._isParent = isParent;
    this._isInternal = isInternal;
    this._iconImageUrl = iconImageUrl;
    this._metaData = metaData;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get providerType => _providerType;
  set providerType(String providerType) => _providerType = providerType;
  bool get isHidden => _isHidden;
  set isHidden(bool isHidden) => _isHidden = isHidden;
  bool get isVirtual => _isVirtual;
  set isVirtual(bool isVirtual) => _isVirtual = isVirtual;
  String get externalId => _externalId;
  set externalId(String externalId) => _externalId = externalId;
  String get name => _name;
  set name(String name) => _name = name;
  bool get isParent => _isParent;
  set isParent(bool isParent) => _isParent = isParent;
  bool get isInternal => _isInternal;
  set isInternal(bool isInternal) => _isInternal = isInternal;
  String get iconImageUrl => _iconImageUrl;
  set iconImageUrl(String iconImageUrl) => _iconImageUrl = iconImageUrl;
  MetaData get metaData => _metaData;
  set metaData(MetaData metaData) => _metaData = metaData;

  Content.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _providerType = json['ProviderType'];
    _isHidden = json['IsHidden'];
    _isVirtual = json['IsVirtual'];
    _externalId = json['ExternalId'];
    _name = json['Name'];
    _isParent = json['IsParent'];
    _isInternal = json['IsInternal'];
    _iconImageUrl = json['IconImageUrl'];
    _metaData = json['MetaData'] != null
        ? new MetaData.fromJson(json['MetaData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['ProviderType'] = this._providerType;
    data['IsHidden'] = this._isHidden;
    data['IsVirtual'] = this._isVirtual;
    data['ExternalId'] = this._externalId;
    data['Name'] = this._name;
    data['IsParent'] = this._isParent;
    data['IsInternal'] = this._isInternal;
    data['IconImageUrl'] = this._iconImageUrl;
    return data;
  }
}

class MetaData {
  List<Item> _item;

  MetaData({List<Item> item}) {
    this._item = item;
  }

  List<Item> get item => _item;
  set item(List<Item> item) => _item = item;

  MetaData.fromJson(Map<String, dynamic> json) {
    if (json['Item'] != null) {
      _item = <Item>[];
      json['Item'].forEach((v) {
        _item.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._item != null) {
      data['Item'] = this._item.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String _name;
  String _value;

  Item({String name, String value}) {
    this._name = name;
    this._value = value;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get value => _value;
  set value(String value) => _value = value;

  Item.fromJson(Map<String, dynamic> json) {
    _name = json['Name'];
    _value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this._name;
    data['Value'] = this._value;
    return data;
  }
}
