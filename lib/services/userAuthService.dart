import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/user_response.dart';
import 'package:http/http.dart' as http;

class UserAuthService {
  Future<UserResponse> userLogin(username, password) async {
    print("Service Called");
    var user;
    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('http://178.128.110.84/htb_demo/api_v1/login'));
    // request.fields.addAll({'username': 'kunsakol', 'password': '12345678'});

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${Constant.khUrl}/login'));
      request.fields.addAll({'username': username, 'password': password});

      request
          .send()
          .then((result) async {
            http.Response.fromStream(result).then((response) {
              print("statuscode: ${response.statusCode}");
              if (response.statusCode == 200) {
                print('response.body ' + response.body);
                user = json.decode(response.body);
              }
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});

      return UserResponse.fromJson(user);
    } catch (e) {
      return null;
    }
  }
}
