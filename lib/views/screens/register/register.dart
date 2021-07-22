import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:htb_mobile/views/screens/register/verify.dart';

import '../../../login.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List _gender = ["Male", "Female"];
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String gender = "";
  bool _emailValidate = false;
  bool _usernameValidate = false;
  bool _phoneValidate = false;
  bool _passwordValidate = false;
  bool _confirmPasswordValidate = false;
  String email_errorLabel;
  String phone_errorLabel;
  bool checkRegistrationForm = false;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentGender;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();

    _currentGender = _gender[0];
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _gender) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildRegisterLayout(context),
    );
  }

  Widget _buildRegisterLayout(context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildLoginFields(context),
        )
      ],
    );
  }

  Widget _buildLoginFields(context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 80.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppLogo(),
            SizedBox(
              height: 40.0,
            ),
            _buildEmailField(),
            SizedBox(
              height: 10.0,
            ),
            _buildPhoneNumberField(),
            SizedBox(
              height: 10.0,
            ),
            _buildUsernameField(),
            SizedBox(
              height: 10.0,
            ),
            _buildGenderField(),
            SizedBox(
              height: 10.0,
            ),
            _buildPasswordField(),
            SizedBox(
              height: 10.0,
            ),
            _buildPasswordConfirmField(),
            SizedBox(
              height: 10.0,
            ),
            _buildSubmitButton(context),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
          labelText: 'Email',
          errorText: _emailValidate ? email_errorLabel : null),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration(
          labelText: 'Phone',
          errorText: _phoneValidate ? phone_errorLabel : null),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
          labelText: 'Username',
          errorText: _usernameValidate ? 'username can\'t be empty' : null),
    );
  }

  Widget _buildGenderField() {
    return new DropdownButton(
      value: _currentGender,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );
  }

  void changedDropDownItem(String selectedGender) {
    setState(() {
      gender = selectedGender;
      _currentGender = selectedGender;
    });
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: _passwordValidate
              ? 'password must be at least 8 characters'
              : null),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          errorText: _confirmPasswordValidate
              ? 'the confrim password do not match'
              : null),
    );
  }

  Widget _buildSubmitButton(context) {
    return RaisedButton(
      onPressed: () {
        checkRegisterForm();
        if (checkRegistrationForm) {
          sendVerificationCode(phoneController.text);
          if (gender == "") gender = _currentGender;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Verify(
                        email: emailController.text,
                        phone: phoneController.text,
                        username: usernameController.text,
                        gender: gender,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      )));
        }
      },
      color: Colors.grey[300],
      child: Text(
        'Next',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> checkRegisterForm() async {
    bool email, phone, username, password, confirmPassword = false;
    if (checkEmpty(emailController) || !validateEmail(emailController.text)) {
      setState(() {
        _emailValidate = true;
        email_errorLabel = 'email must be valid and can\'t be empty';
      });
    } else {
      var request = http.MultipartRequest('POST',
          Uri.parse('http://178.128.110.84/htb_demo/api_v1/check-exist-email'));
      request.fields.addAll({'email': emailController.text});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        email = true;
        setState(() {
          _emailValidate = false;
        });
      } else {
        print(response.reasonPhrase);
        setState(() {
          _emailValidate = true;
          email_errorLabel = 'email has already in used';
        });
      }
    }

    if (checkEmpty(phoneController) || validateMobile(phoneController.text)) {
      setState(() {
        _phoneValidate = true;
        phone_errorLabel = 'phone must be valid and can\'t be empty';
      });
    } else {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://178.128.110.84/htb_demo/api_v1/check-exist-phone-number'));
      request.fields.addAll({'phone': phoneController.text});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        phone = true;
        setState(() {
          _phoneValidate = false;
        });
      } else {
        setState(() {
          _phoneValidate = true;
          phone_errorLabel = 'phone has already in used';
        });

        print(response.reasonPhrase);
      }
    }

    if (checkEmpty(usernameController)) {
      setState(() {
        _usernameValidate = true;
      });
    } else {
      username = true;
      setState(() {
        _usernameValidate = false;
      });
    }
    if (checkEmpty(passwordController)) {
      setState(() {
        _passwordValidate = true;
      });
    } else {
      password = true;
      setState(() {
        _passwordValidate = false;
      });
    }
    if (checkEmpty(confirmPasswordController) || !checkPasswordMatch()) {
      setState(() {
        _confirmPasswordValidate = true;
      });
    } else {
      confirmPassword = true;
      setState(() {
        _confirmPasswordValidate = false;
      });
    }

    if (email == true &&
        username == true &&
        phone == true &&
        password == true &&
        confirmPassword == true) {
      print("validate true");
      checkRegistrationForm = true;
    } else {
      print("validate false");
      checkRegistrationForm = false;
    }
  }

  bool checkEmpty(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPasswordMatch() {
    if (passwordController.text == confirmPasswordController.text)
      return true;
    else
      return false;
  }

  bool validateMobile(String phone) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{9,12}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(phone)) {
      print("not match");
      return true;
    }
    return false;
  }

  bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }
}

void sendVerificationCode(String phone) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://178.128.110.84/htb_demo/api_v1/send-code-by-phone-number'));
  request.fields.addAll({'phone': phone});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
