class OrderedHistory {
  List<ListOrders> listOrders;
  String limitPage;
  String page;
  String lastPage;

  OrderedHistory({this.listOrders, this.limitPage, this.page, this.lastPage});

  OrderedHistory.fromJson(Map<String, dynamic> json) {
    if (json['list_orders'] != null) {
      listOrders = <ListOrders>[];
      json['list_orders'].forEach((v) {
        listOrders.add(new ListOrders.fromJson(v));
      });
    }
    limitPage = json['limit_page'];
    page = json['page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listOrders != null) {
      data['list_orders'] = this.listOrders.map((v) => v.toJson()).toList();
    }
    data['limit_page'] = this.limitPage;
    data['page'] = this.page;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class ListOrders {
  String orderId;
  String reference;
  String date;
  String servicePercentage;
  String exchangeY;
  String totalCost;
  String total;
  String service;
  String deposit;
  String grantTotal;
  String totalPayment;
  String totalAmount;
  String totalCancel;
  String netTotal;
  String balance;
  String status;
  String paymentStatus;
  String description;

  ListOrders(
      {this.orderId,
      this.reference,
      this.date,
      this.servicePercentage,
      this.exchangeY,
      this.totalCost,
      this.total,
      this.service,
      this.deposit,
      this.grantTotal,
      this.totalPayment,
      this.totalAmount,
      this.totalCancel,
      this.netTotal,
      this.balance,
      this.status,
      this.paymentStatus,
      this.description});

  ListOrders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    reference = json['reference'];
    date = json['date'];
    servicePercentage = json['service_percentage'];
    exchangeY = json['exchange_y'];
    totalCost = json['total_cost'];
    total = json['total'];
    service = json['service'];
    deposit = json['deposit'];
    grantTotal = json['grant_total'];
    totalPayment = json['total_payment'];
    totalAmount = json['total_amount'];
    totalCancel = json['total_cancel'];
    netTotal = json['net_total'];
    balance = json['balance'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['reference'] = this.reference;
    data['date'] = this.date;
    data['service_percentage'] = this.servicePercentage;
    data['exchange_y'] = this.exchangeY;
    data['total_cost'] = this.totalCost;
    data['total'] = this.total;
    data['service'] = this.service;
    data['deposit'] = this.deposit;
    data['grant_total'] = this.grantTotal;
    data['total_payment'] = this.totalPayment;
    data['total_amount'] = this.totalAmount;
    data['total_cancel'] = this.totalCancel;
    data['net_total'] = this.netTotal;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['description'] = this.description;
    return data;
  }
}
