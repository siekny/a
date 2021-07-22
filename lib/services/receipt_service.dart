import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/receipt.dart';
import 'package:htb_mobile/views/widgets/alert_dialog.dart';
import 'package:http/http.dart' as http;

int limitPage = 20;

class ReceiptService {
  List<String> receipts = [];

  Receipt receipt;
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Future<Receipt> getReceipt(int page) async {
    print('page $page');
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/get-receipt?limit_page=$limitPage&page=$page&token=${Constant.getToken()}");

      final receipt = Receipt.fromJson(jsonDecode(res.body)['data']);

      return receipt;
      // }
    } catch (e) {
      print(e.toString());
      AlertDialig();
      return null;
      // throw e;
    }
  }

  void addReceiptsInLocal(String filePath) {
    receipts.add(filePath);
  }

  List<String> listReceiptsInLocal() {
    return receipts;
  }
}
