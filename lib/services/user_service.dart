import 'dart:convert';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/data/models/user.dart';
import 'package:htb_mobile/data/models/user_response.dart';
import 'package:htb_mobile/views/widgets/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class UserService {
  User user;
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Future<User> getUser() async {
    try {
      final res = await http
          .get("${Constant.khUrl}/get_profile?token=${Constant.getToken()}");

      final user = User.fromJson(jsonDecode(res.body)['data']);

      return user;
      // }
    } catch (e) {
      print(e.toString());
      AlertDialig();
      return null;
      // throw e;
    }
  }

  // update profile
  Future<void> updateUser(user) async {
    try {
      final res = await http.post(
        '${Constant.khUrl}/update_profile?token=${Constant.getToken()}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user,
      );
      if (res.statusCode == 200) {
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> postImage(imageFile) async {
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "token": Constant.getToken(),
      };

      var length = await imageFile.length();
      print(length);
      String url =
          '${Constant.khUrl}/upload/image?token=${Constant.getToken()}';
      final fineName = path.basename(imageFile.path);
      http.MultipartRequest request =
          new http.MultipartRequest('POST', Uri.parse(url))
            ..headers.addAll(headers)
            ..files.add(
              // replace file with your field name exampe: image
              http.MultipartFile('image', imageFile.openRead(), length,
                  filename: fineName),
            );

      var respons = await http.Response.fromStream(await request.send());

      if (respons.statusCode == 200) {
        String image = jsonDecode(respons.body)['data']['image'];

        return image;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserResponse> userLogin(username, password) async {
    try {
      var user;
      var request =
          http.MultipartRequest('POST', Uri.parse('${Constant.khUrl}/login'));
      request.fields.addAll({'username': username, 'password': password});

      request
          .send()
          .then((result) async {
            http.Response.fromStream(result).then((response) {
              if (response.statusCode == 200) {
                print('response.body ' + response.body);
                user = json.decode(response.body);
              }
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});

      return UserResponse.fromJson(user);
    } catch (e) {}
  }
}
