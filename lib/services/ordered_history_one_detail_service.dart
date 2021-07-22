import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/ordered_history_detail.dart';
import 'package:http/http.dart' as http;

class OrderedHistoryDetailService {
  Future<OrderedHistoryDetail> getOrderedHistoryDetail(int orderId) async {
    OrderedHistoryDetail orderDetail = new OrderedHistoryDetail();
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/history/detail?order_id=$orderId&token=${Constant.getToken()}");
      orderDetail.code = res.statusCode;
      if (res.statusCode == 200) {
        orderDetail.data = Data.fromJson(jsonDecode(res.body)['data']);
      }
    } catch (e) {
      orderDetail.description = e.toString();
    }
    return orderDetail;
  }

  Future<List<AwaitingApproval>> getAwaitingApprovalDetail(int orderId) async {
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/awaiting-approval/detail?order_id=$orderId&token=${Constant.getToken()}");
      print('status_code ${res.statusCode}');
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body)['data'] as List;
        final orders =
            list.map((order) => AwaitingApproval.fromJson(order)).toList();
        print('Order_result $orders');

        return orders;
      }

      return null;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  Future<String> uploadReceipt(String filepath, String orderId) async {
    String url = '${Constant.khUrl}/order/history/upload-receipt';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    request.fields['order_id'] = orderId;
    request.fields['token'] = Constant.getToken();

    var res = await request.send();
    print('response ${res.request}');
    return res.reasonPhrase;
  }

  // remove One Wishlist
  Future<void> deleteReceipt(String receiptId) async {
    print('wishlist id $receiptId');
    try {
      final res = await http.get(
          '${Constant.khUrl}/order/history/remove-receipt?receipt_id=$receiptId&token=${Constant.getToken()}');
      print('status code ${res.statusCode}');
      if (res.statusCode == 200) {
        print('success');
      } else {
        throw Exception('Failed to remove receipt');
      }
    } catch (e) {
      print(e.toString());
      // throw e;
    }
  }
}
