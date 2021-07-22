import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/rating_category.dart';
import 'package:http/http.dart' as http;

class RatingCategoryService {
  Future<RatingCategory> getRatingCategories() async {
    var rr;

    try {
      if (Constant.ratingCategory == null) {
        rr = await http.get(
            'http://otapi.net/service-json/BatchSearchRatingLists?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&applicationType=Website&xmlSearchParameters=%3CBatchRatingListSearchParameters%3E%3CUseDefaultParameters%3Etrue%3C%2FUseDefaultParameters%3E%3C%2FBatchRatingListSearchParameters%3E');
        if (rr.statusCode == 200) {
          Constant.ratingCategory = json.decode(rr.body);
          rr = json.decode(rr.body);
        } else {
          print('throw from api');
          // throw 'Error from API';
        }
      } else {
        rr = Constant.ratingCategory;
      }

      return RatingCategory.fromJson(rr);
    } catch (e) {
      return null;
    }
  }
}
