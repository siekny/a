import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../login.dart';

class Verify extends StatefulWidget {
  final email, phone, username, gender, password, confirmPassword;
  Verify(
      {Key key,
      @required this.email,
      @required this.phone,
      @required this.username,
      @required this.gender,
      @required this.password,
      @required this.confirmPassword})
      : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final verifyController = TextEditingController();
  bool _verifyValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildRegisterLayout(),
    );
  }

  Widget _buildRegisterLayout() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: _buildLoginFields(),
        )
      ],
    );
  }

  Widget _buildLoginFields() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 80.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppLogo(),
            SizedBox(
              height: 70.0,
            ),
            _buildEmailField(),
            SizedBox(
              height: 20.0,
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: verifyController,
      decoration: InputDecoration(
          labelText: 'Enter verification code',
          errorText: _verifyValidate ? 'wrong verifation code' : null),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        register();
      },
      color: Colors.grey[300],
      child: Text(
        'Verify',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }

  void register() async {
    print(widget.phone);

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://178.128.110.84/htb_demo/api_v1/register'));
    request.fields.addAll({
      'full_name': widget.username,
      'phone': widget.phone,
      'email': widget.email,
      'company_name': 'NA',
      'address': 'NA',
      'username': widget.username,
      'password': widget.password,
      'password_confirmation': widget.confirmPassword,
      'verification_code': verifyController.text
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      print(await response.stream.bytesToString());
    } else {
      print("error");
      print(response.stream.bytesToString());
    }
  }
}
