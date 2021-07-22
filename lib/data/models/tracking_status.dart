class TrackingStatus {
  String typeId;
  String icon;
  String title;
  String date;
  String sortNum;
  bool isSelected;
  bool isCurrent;

  TrackingStatus(
      {this.typeId,
      this.icon,
      this.title,
      this.date,
      this.sortNum,
      this.isSelected,
      this.isCurrent});

  TrackingStatus.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    icon = json['icon'];
    title = json['title'];
    date = json['date'];
    sortNum = json['sort_num'];
    isSelected = json['is_selected'];
    isCurrent = json['is_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['date'] = this.date;
    data['sort_num'] = this.sortNum;
    data['is_selected'] = this.isSelected;
    data['is_current'] = this.isCurrent;
    return data;
  }
}
