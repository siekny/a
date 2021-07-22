class Receipt {
  List<String> receiptUploads;
  String limitPage;
  String page;
  String lastPage;

  Receipt({this.receiptUploads, this.limitPage, this.page, this.lastPage});

  Receipt.fromJson(Map<String, dynamic> json) {
    receiptUploads = json['receipt_uploads'].cast<String>();
    limitPage = json['limit_page'];
    page = json['page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_uploads'] = this.receiptUploads;
    data['limit_page'] = this.limitPage;
    data['page'] = this.page;
    data['last_page'] = this.lastPage;
    return data;
  }
}
