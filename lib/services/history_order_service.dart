import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/history_order.dart';
import 'package:http/http.dart' as http;

class OrderedHistoryService {
  int limit = 10;

  Future<OrderedHistory> getOrderedHistories(int page) async {
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/history/list?limit_page=$limit&page=$page&token=${Constant.getToken()}");
      print('status code ${res.statusCode}');
      if (res.statusCode == 200) {
        final order = OrderedHistory.fromJson(jsonDecode(res.body)['data']);
        print('order ${order.listOrders}');
        return order;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
      // throw e;
    }
  }

  Future<OrderedHistory> getAwaitingApproval(int page) async {
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/awaiting-approval/list?limit_page=$limit&page=$page&token=${Constant.getToken()}");
      print('status code ${res.statusCode}');
      if (res.statusCode == 200) {
        final order = OrderedHistory.fromJson(jsonDecode(res.body)['data']);
        print('order_service ${order?.listOrders[0].totalAmount}');
        return order;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
      // throw e;
    }
  }
}
