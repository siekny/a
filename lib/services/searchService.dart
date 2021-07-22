import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/global_items.dart';
import 'package:htb_mobile/data/models/image_response.dart';
import 'package:http/http.dart' as http;

class SearchSerivce {
  Future<GlobalItems> getSearchResultbyCategoryID(
      var search, int from, int to, String order) async {
    Constant.isSearchbyPhoto = false;
    var string = search;
    print("Numberic" + search);
    var r;
    var xmlParam;

    if (isNumeric(search) ||
        string.toString().contains('otc') ||
        string.toString().contains('abb')) {
      print('Is Category');
      xmlParam = "<SearchItemsParameters><CategoryId>" +
          search +
          "</CategoryId><OrderBy>" +
          checkOrder(order) +
          "</OrderBy><Configurators>" +
          checkConfigurators() +
          "</Configurators></SearchItemsParameters>";
      r = await http.get(
          "http://otapi.net/service-json/BatchSearchItemsFrame?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&sessionId=&xmlParameters=" +
              xmlParam +
              "&framePosition=" +
              from.toString() +
              "&frameSize=" +
              to.toString() +
              "&blockList=AvailableSearchMethods,SearchProperties,SubCategories");
    } else {
      print('Not Numberic');

      if (Constant.isTaobao) {
        xmlParam =
            "<SearchItemsParameters><Provider>Taobao</Provider><ItemTitle>" +
                search +
                "</ItemTitle>" +
                "<Configurators>" +
                checkConfigurators() +
                "</Configurators></SearchItemsParameters>";
      } else {
        xmlParam =
            "<SearchItemsParameters><Provider>Alibaba1688</Provider><ItemTitle>" +
                search +
                "</ItemTitle>" +
                "<Configurators>" +
                checkConfigurators() +
                "</Configurators></SearchItemsParameters>";
      }
      print(xmlParam);
      // Final Request
      r = await http.get(
          "http://otapi.net/service-json/BatchSearchItemsFrame?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&sessionId=&xmlParameters=" +
              xmlParam +
              "&framePosition=" +
              from.toString() +
              "&frameSize=" +
              to.toString() +
              "&blockList=AvailableSearchMethods,SearchProperties,SubCategories");
    }

    if (r.statusCode == 200) {
      print("Search" + r.body);
      print("after pushing...");
      r = json.decode(r.body);
    } else {
      print('throw error fro api');
      // throw 'Error from API';
    }

    return GlobalItems.fromJson(r);
  }

  Future<String> uploadImagetoAPI(var _path) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://178.128.110.84/htb_demo/api_v1/upload/search/image'));
    request.files.add(await http.MultipartFile.fromPath('image', _path));

    // var response = await request.send();
    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              print("Uploaded! ");
              print('response.body ' + response.body);
              var converted = ImageReponse.fromJson(jsonDecode(response.body));
              Constant.globalImageSearch = converted.data.image;
            }
            return Constant.globalImageSearch;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }

  Future<GlobalItems> getSearchResultbyImage(
      var photo, var from, var to) async {
    // uploadImagetoAPI(photo);
    print("getSearchResultbyImage");
    var r;
    var search = "<SearchItemsParameters><ImageUrl>" +
        photo +
        "</ImageUrl></SearchItemsParameters>";

    r = await http.get(
        "http://otapi.net/service-json/BatchSearchItemsFrame?instanceKey=638da669-373b-4d3f-92a6-899c335ff7e6&language=en&signature=&timestamp=&sessionId=&xmlParameters=" +
            search +
            "&framePosition=" +
            from.toString() +
            "&frameSize=" +
            to.toString() +
            "&blockList=SearchProperties");

    if (r.statusCode == 200) {
      print("Search" + r.body);
      print("after searching...");
      print(r.statusCode);
      r = json.decode(r.body);
    } else {
      print('throw from api');
      // throw 'Error from API';
    }

    return GlobalItems.fromJson(r);
  }
}

String checkConfigurators() {
  String configurators = "";
  if (Constant.filterProperties != null) {
    for (var i = 0; i < Constant.filterProperties.length; i++) {
      print("at $i" + Constant.filterProperties[i].toString());
      Constant.filterProperties[i].entries.forEach((element) {
        configurators += '<Configurator Pid=' +
            '"' +
            element.key +
            '"' +
            ' ' +
            'Vid="' +
            element.value +
            '"/>';
      });
    }
  } else {
    configurators = "";
  }

  // configurators = '<Configurator Pid="20509" Vid="28315"/>';
  // configurators += configurators;
  print("return strign" + configurators);
  Constant.filterProperties.clear();
  return configurators;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

String checkOrder(String order) {
  String lastOrder;
  if (order.contains("Default order"))
    lastOrder = "Default:Asc";
  else if (order.contains("Price in ascending order"))
    lastOrder = "Price:Asc";
  else if (order.contains("Price in descending order"))
    lastOrder = "Price:Desc";
  else if (order.contains("Total price in ascending order"))
    lastOrder = "TotalPrice:Asc";
  else if (order.contains("Total price in descending order"))
    lastOrder = "TotalPrice:Desc";
  else if (order.contains("Volume of sales in descending order"))
    lastOrder = "Volume:Desc";
  else
    lastOrder = "VendorRating:Desc";

  print("Last order" + lastOrder);
  return lastOrder;
}
