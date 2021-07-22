class UserResponse {
  int code;
  String description;
  Data data;

  UserResponse({this.code, this.description, this.data});


  UserResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String fullName;
  String username;
  String email;
  String phone;
  String image;
  String token;

  Data(
      {this.fullName,
      this.username,
      this.email,
      this.phone,
      this.image,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}