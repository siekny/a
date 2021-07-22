import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/tracking.dart';
import 'package:htb_mobile/data/models/tracking_status.dart';
import 'package:http/http.dart' as http;

class TrackingService {
  Future<List<TrackingStatus>> getTrackingStatuses() async {
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/tracking/get-status?token=${Constant.getToken()}");
      if (res.statusCode == 200) {
        final list = json.decode(res.body)['data'] as List;
        final statuses =
            list.map((order) => TrackingStatus.fromJson(order)).toList();
        print('status $statuses');
        return statuses;
      }

      return null;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  Future<Tracking> getTrackingByItemCode(String code) async {
    Tracking tracking = new Tracking();
    try {
      final res = await http.get(
          "${Constant.khUrl}/order/tracking/get-tracking-product?product_code=$code&token=${Constant.getToken()}");
      tracking.code = res.statusCode;
      if (res.statusCode == 200) {
        tracking.data = TrackingData.fromJson(jsonDecode(res.body)['data']);
        tracking.data.trackingStatus.sort((preStatus, nextStatus) =>
            int.parse(preStatus.typeId)
                .compareTo(int.parse(nextStatus.typeId)));
      }
    } catch (e) {
      tracking.message = e.toString();
    }
    return tracking;
  }
}
