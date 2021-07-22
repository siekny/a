import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/wishlist.dart';
import 'package:http/http.dart' as http;

class WishListService {
  Future<Wishlist> getWishLists() async {
    try {
      final res = await http
          .get("${Constant.khUrl}/view_whistlist?token=${Constant.getToken()}");
      if (res.statusCode == 200) {
        final wishlist = Wishlist.fromJson(jsonDecode(res.body)['data']);

        return wishlist;
      }

      return null;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  // remove One Wishlist
  Future<void> removeOneWishlist(String wishlistId) async {
    print('wishlist id $wishlistId');
    try {
      final res = await http.post(
        '${Constant.khUrl}/delete_whistlist',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {'whistlist_id': wishlistId, 'token': Constant.getToken()}),
      );
      if (res.statusCode == 200) {
      } else {
        throw Exception('Failed to remove wishlist');
      }
    } catch (e) {
      print(e.toString());
      // throw e;
    }
  }

  // update profile
  Future<void> addwishlist(wishlist) async {
    print('wishlist $wishlist');
    try {
      final res = await http.post(
        '${Constant.khUrl}/add_whistlist',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: wishlist,
      );
      if (res.statusCode == 200) {
      } else {
        print("Failed to add wishlist");
        // throw Exception('Failed to add wishlist');
      }
    } catch (e) {
      print(e.toString());
      // throw e;
    }
  }
}
