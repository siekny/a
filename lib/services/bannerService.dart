import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/banner.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<BannerOT> getBanners() async {
    var rr;
    if (Constant.bannerList == null) {
      try {
        rr = await http.get(
            'http://otapi.net/service-json/GetBanners?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&applicationType=');
        if (rr.statusCode == 200) {
          print("success getting banners");
          rr = json.decode(rr.body);
          Constant.bannerList = rr;
        } else {
          print('Error from API');
          //throw 'Error from API';
        }
      } catch (e) {
        print('error $e');
      }
    } else {
      rr = Constant.bannerList;
    }

    return BannerOT.fromJson(rr);
  }
}
