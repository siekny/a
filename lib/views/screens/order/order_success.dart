import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/ButtonField.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../main.dart';

class OrderSuccessScreen extends StatefulWidget {
  @override
  _OrderSuccessScreenState createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  double sizeBetween;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(
          child: Icon(
            MdiIcons.checkBold,
            size: 36,
          ),
          backgroundColor: HexColor.fromHex('#5CB85C'),
          foregroundColor: HexColor.fromHex('#ffffff'),
          minRadius: 30,
        ),
        SizedBox(height: 20),
        Text(
          'Your Order is Completed',
          style: TextStyle(
              color: HexColor.fromHex('#0D0D0D'),
              fontSize: 22,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 20),
        Text(
          'Thank you for your order! Your order is being processed and will be completed within 3-6 hours. You will receive an email confirmation when your order is completed.',
          style: TextStyle(color: HexColor.fromHex('#969696'), fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ButtonField(
            title: 'Continue Shopping',
            fontSize: 18,
            backgroundColor: HexColor.fromHex('#5CB85C'),
            borderColor: HexColor.fromHex('#5CB85C'),
            onPressed: _validateAndSend),
      ]),
    ));
  }

  void _validateAndSend() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main()));
  }
}
