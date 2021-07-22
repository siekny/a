import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:htb_mobile/main.dart';

import 'package:htb_mobile/views/screens/register/register.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/constant.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   HttpOverrides.global = new MyHttpOverrides();

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var username = prefs.getString('username');
//   print(username);
//   runApp(MaterialApp(home: username == null ? SubMain() : SubMain()));
//   // runApp(MaterialApp(
//   //   home: MyApp(),
//   // ));
// }

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildLoginLayout(context),
    );
  }

  final phoneController = TextEditingController();
  final verifyCodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _usernameValidate = false;
  bool _passwordValidate = false;
  bool _phoneValidate = false;
  bool _codeValidate = false;
  bool _newPasswordValidate = false;
  bool _newConfirmPasswordValidate = false;
  String code_errorLabel;
  String phone_errorLabel;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    // _btnController.reset();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildLoginLayout(context) {
  
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: AppLogo(),
        ),
        Align(
          alignment: Alignment.center,
          child: _buildLoginFields(context),
        ),
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
            _buildUsernameField(),
            SizedBox(
              height: 10.0,
            ),
            _buildPasswordField(),
            SizedBox(
              height: 20.0,
            ),
            _buildSubmitButton(context),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildForgetPasswordText(context),
                  flex: 6,
                ),
                Expanded(
                  child: _buildRegisterText(context),
                  flex: 4,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
          labelText: 'Username',
          errorText: _usernameValidate ? 'Username Can\'t be Empty' : null),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: _passwordValidate ? 'Password can\'t be Empty' : null),
    );
  }

  Widget _buildSplashScreen() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.network(
            "http://kimleang.xyz/images/logoz.png",
            width: 250,
            height: 250,
          ),
        ));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: () {
        if (login(usernameController, passwordController, context)) {
          var request = http.MultipartRequest(
              'POST', Uri.parse('${Constant.khUrl}/login'));
          request.fields.addAll({
            'username': usernameController.text,
            'password': passwordController.text
          });

          request
              .send()
              .then((result) async {
                http.Response.fromStream(result).then((response) async {
                  if (response.statusCode == 200) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var v = jsonDecode(response.body);
                    Constant.token = v["data"]["token"];
                    prefs.setString('token', v["data"]["token"]);
                    print("Constant.token>>"+Constant.token);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Main()));
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    _btnController.reset();
                    Toast.show("Invalid user input", context,
                        backgroundColor: Colors.red,
                        duration: 5,
                        gravity: Toast.BOTTOM);
                  }
                });
              })
              .catchError((err) => print('error : ' + err.toString()))
              .whenComplete(() {});

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => BlocProvider<UserAuthCubit>(
          //         create: (context) =>
          //             UserAuthCubit()..userLogin("kunsakol", "12345678"),
          //         child: LoadingScreen(),
          //       ),
          //     ));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => LoadingScreen()));

          // BlocProvider.of<UserAuthCubit>(context)
          //     .userLogin(usernameController.text, passwordController.text);
        }
      },
      color: Colors.amber[400],
      child: Text(
        'LOGIN',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildRegisterText(context) {
    return GestureDetector(
      onTap: () {
        _btnController.reset();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
      },
      child: Text(
        'REGISTER',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14),
      ),
    );
  }

  Widget _buildForgetPasswordText(context) {
    return GestureDetector(
      onTap: () {
        _showPhoneNumber(context);
      },
      child: Text(
        'Forgot your password?',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14),
      ),
    );
  }

  bool login(TextEditingController usernameController,
      TextEditingController passwordController, BuildContext context) {
    bool b = false;
    if (usernameController.text.isEmpty) {
      b = false;
      setState(() {
        _usernameValidate = true;
        _btnController.reset();
      });
    } else {
      setState(() {
        _usernameValidate = false;
      });
    }

    if (passwordController.text.isEmpty) {
      b = false;
      setState(() {
        _passwordValidate = true;
        _btnController.reset();
      });
    } else {
      setState(() {
        _passwordValidate = false;
      });
    }

    if (passwordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      b = true;
      setState(() {
        _usernameValidate = false;
        _passwordValidate = false;
      });
      return b;
    }
  }

  void _showPhoneNumber(BuildContext ctx) {
    bool phone_isPressed = false;
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        errorText: _phoneValidate ? phone_errorLabel : null),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        sendVerifyCode(ctx);
                      },
                      child: Text('Submit'))
                ],
              ),
            ));
  }

  void _showVerification(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        errorText: _phoneValidate ? phone_errorLabel : null),
                  ),
                  TextField(
                    controller: verifyCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Code',
                        errorText: _codeValidate ? code_errorLabel : null),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showCodeConfirmation(ctx);
                      },
                      child: Text('Submit'))
                ],
              ),
            ));
  }

  void _showPasswordChanged(BuildContext ctx) {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        errorText: _phoneValidate ? phone_errorLabel : null),
                  ),
                  TextField(
                    controller: verifyCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Code',
                        errorText:
                            _codeValidate ? 'code can\'t be empty' : null),
                  ),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'password',
                        errorText: _newPasswordValidate
                            ? 'password can\'t be empty'
                            : null),
                  ),
                  TextField(
                    controller: newConfirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'confirm password',
                        errorText: _newConfirmPasswordValidate
                            ? 'confirm password is not match'
                            : null),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        sendRequestChangePassword(ctx);
                        // Navigator.pop(ctx);
                      },
                      child: Text('Submit'))
                ],
              ),
            ));
  }

  Future<void> sendVerifyCode(ctx) async {
    if (phoneController.text.isEmpty) {
      setState(() {
        _phoneValidate = true;
      });
    } else {
      setState(() {
        _phoneValidate = false;
      });
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Constant.khUrl}/forgot-password/send'));
      request.fields.addAll({'phone': phoneController.text});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Navigator.pop(ctx);
        _showVerification(ctx);
      } else {
        setState(() {
          _phoneValidate = true;
          phone_errorLabel = "This phone number has never been registered";
        });
        print(response.reasonPhrase);
      }
    }
  }

  Future<void> showCodeConfirmation(BuildContext ctx) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.khUrl}/forgot-password/confirm-code'));
    request.fields.addAll({
      'phone': phoneController.text,
      'confirm_code': verifyCodeController.text
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(ctx);
      _showPasswordChanged(ctx);
    } else {
      print(response.reasonPhrase);
      setState(() {
        _codeValidate = true;
        code_errorLabel = "invalid code";
      });
    }
  }

  Future<void> sendRequestChangePassword(BuildContext ctx) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.khUrl}/forgot-password/change-password'));
    request.fields.addAll({
      'phone': phoneController.text,
      'confirm_code': verifyCodeController.text,
      'password': newPasswordController.text,
      'password_confirmation': newConfirmPasswordController.text
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pop(ctx);
      Toast.show("Your password has been changed", ctx,
          backgroundColor: Colors.green, duration: 3, gravity: Toast.BOTTOM);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Image.network(
        "http://kimleang.xyz/images/logoz.png",
        width: 250,
        height: 250,
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.amber;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
