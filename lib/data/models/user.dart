class User {
  String fullName;
  String username;
  String email;
  String phone;
  String companyName;
  String address;
  String image;

  User(
      {this.fullName,
      this.username,
      this.email,
      this.phone,
      this.companyName,
      this.address,
      this.image});

  String get getFullname => this.fullName;
  String get getUsername => this.username;
  String get getEmail => this.email;
  String get getPhone => this.phone;
  String get getCompanyName => this.companyName;
  String get getAddress => this.address;
  String get getImage => this.image;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      companyName: json['company_name'],
      address: json['address'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['image'] = this.image;
    return data;
  }
}
