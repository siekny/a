import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/product_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Repository {
  final ruBaseUrl = "http://otapi.net/service-json/";
  final khBaseUrl = "http://178.128.110.84/htb_demo/api_v1/";

  Future<Map<String, dynamic>> getProductInfo(String id) async {
    final path =
        Constant.getInstanceMethod("BatchGetSimplifiedItemFullInfo", id) +
            "&blockList=Description";

    try {
      final response = await http.get(ruBaseUrl + path);
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> getProductConfig(String id) async {
    final path = Constant.getInstanceMethod(
            "BatchGetSimplifiedItemConfigurationInfo", id) +
        "&xmlRequest=<Request><Current%20Quantity=%271%27></Current></Request>&blockList=AdditionalPrices";

    try {
      final response = await http.get(ruBaseUrl + path);
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> viewCart(String token) async {
    final path = "view_cart";

    try {
      final response = await http.get(khBaseUrl + path, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final data = json.decode(response.body) as Map<String, dynamic>;

      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Map<String, dynamic>> deleteCart(String token, String id) async {
    final path = "delete_cart";

    try {
      http.post(khBaseUrl + path,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({'cart_id': id}));

      return viewCart(token);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ProductDetail> updateCart(
      int oldQty, String cartId, bool isIncrement, double price) async {
    var qty;
    if (isIncrement) {
      qty = oldQty + 1;
    } else {
      qty = oldQty - 1;
    }
    if (qty < 1) return null;

    var amount = (price * qty).toString();
    final cartObj = {
      "quantity": "${qty.toString()}",
      "price": "${price.toString()}",
      "amount": "$amount",
      "cart_id": "${cartId.toString()}",
      "token": "${Constant.token}",
    };

    final path = "edit_cart";

    try {
      var request = await http.post(khBaseUrl + path,
          headers: {
            'Accept': 'application/json',
            "processData": "false",
            "mimeType": "multipart/form-data",
            "contentType": "false",
          },
          body: cartObj);
      var res = jsonDecode(request.body);
      ProductDetail productDetail = ProductDetail(
          price: double.parse(res["data"]["store_cart"]["quantity"]),
          amount: double.parse(res["data"]["store_cart"]["amount"]),
          quantity: int.parse(res["data"]["store_cart"]["quantity"]));
      return productDetail;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> addCart(String token, ProductDetail pro) async {
    final cartObj = {
      "product_name": pro.title,
      "product_code": pro.id,
      "color_size": pro.colorSize,
      "quantity": pro.quantity.toString(),
      "price": pro.price.toString(),
      "amount": (pro.price * pro.quantity).toString(),
      "supplyer": pro.supplyer,
      "color_image_link": "",
      "thumbnail_url": pro.thumnail_url,
      "product_url": pro.product_url,
      "token": token,
    };
    final path = "add_cart";

    try {
      var res = await http.post(khBaseUrl + path,
          headers: {
            'Accept': 'application/json',
            "processData": "false",
            "mimeType": "multipart/form-data",
            "contentType": "false",
          },
          body: cartObj);
      if(res.statusCode==200){
        final data = json.decode(res.body) as Map<String, dynamic>;
        final ids = data["data"]["store_cart"]["cart_id"] as String;
        return int.parse(ids);
      }else{
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> checkout(String token, List<String> ids) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://178.128.110.84/htb_demo/api_v1/check_out'));
      request.body = json.encode({"carts_id": ids, "token": token});
      request.headers.addAll(headers);
      var response = await request.send();
    } catch (e) {}
  }
}
