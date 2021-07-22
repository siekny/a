import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/sub_category.dart';
import 'package:http/http.dart' as http;
import 'package:htb_mobile/data/models/category.dart';

class CategoryService {
  Map<String, dynamic> e;
  Map<String, dynamic> a;

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Future<Category> getCategories() async {
    var rr;
    var cat_id;
    var sub_cat;

    if (Constant.taobaoCategory == null) {
      rr = await http.get(
          'http://otapi.net/service-json/GetRootCategoryInfoList?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=');
      if (rr.statusCode == 200) {
        rr = json.decode(rr.body);
        Constant.taobaoCategory = rr;
        // get id from category
      } else {
        print('throw error fro api');
        // throw 'Error from API';
      }
    } else {
      rr = Constant.taobaoCategory;
    }

    return Category.fromJson(rr);
  }

  Future<Category> getAlibabaCategories() async {
    var res;
    if (Constant.alibabaCategory == null) {
      try {
        res = await http.get(
            "http://otapi.net/service-json/GetCategorySubcategoryInfoList?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&parentCategoryId=abb-0");
        if (res.statusCode == 200) {
          {
            res = json.decode(res.body);
            Constant.alibabaCategory = res;
            // var id = Category.fromJson(res);

            // print(id.categoryInfoList.content[0].externalId);
          }
        }
      } catch (e) {
        print(e.toString());
        // throw e;
      }
    } else {
      res = Constant.alibabaCategory;
    }
    return Category.fromJson(res);
  }

  Future<SubCategory> getSubCategories(String id) async {
    var rr;
    rr = await http.get(
        'http://otapi.net/service-json/GetCategorySubcategoryInfoList?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&parentCategoryId=' +
            id);
    if (rr.statusCode == 200) {
      rr = json.decode(rr.body);
      // print(rr.toString());
      // get id from category
    } else {
      print('throw error fro api');
      // throw 'Error from API';
    }

    return SubCategory.fromJson(rr);
  }
}
