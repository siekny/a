import 'package:flutter/material.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/order/button_order.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar.getAppBar('Option'),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.sidePadding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa4CxHXjQeNUtMxMOF_wpxSO3c6WTlt5zKQQ&usqp=CAU')),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          '\$ 2.5',
                          style: TextStyle(
                              color: HexColor.fromHex('#f00000'),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        )),
                    Text(
                      '16.35¥',
                      style: TextStyle(
                          color: HexColor.fromHex('#818181'),
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),

                // line
                Divider(
                  height: 50,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: HexColor.fromHex('#BDBDC7'),
                ),

                // colors
                Column(children: [
                  // color chosen
                  Row(children: [
                    Text(
                      'Colors: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Black',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ]),
                  SizedBox(height: 10),

                  // list of colors
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#FDBA34'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("Blue",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#9F9F9F'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("Black",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#9F9F9F'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("White",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                    ],
                  )
                ]),

                // line
                Divider(
                  height: 50,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: HexColor.fromHex('#BDBDC7'),
                ),

                Column(children: [
                  // Size chosen
                  Row(children: [
                    Text(
                      'Sizes: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'S',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ]),
                  SizedBox(height: 10),

                  // list of colors
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#FDBA34'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("S",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#9F9F9F'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("M",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: HexColor.fromHex('#9F9F9F'),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
                          child: Text("L",
                              style: TextStyle(
                                  color: HexColor.fromHex('#000000'),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                        ),
                        onTap: () {
                          print("value of your text");
                        },
                      ),
                    ],
                  ),
                  // line
                  Divider(
                    height: 50,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: HexColor.fromHex('#BDBDC7'),
                  ),

                  // Quantity
                  Column(children: [
                    Row(children: [
                      Text(
                        'Quantity ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ]),
                    SizedBox(height: 10),

                    // list of colors
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: HexColor.fromHex('#B9B9B9'),
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    topLeft: Radius.circular(4))),
                            padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                            child: Text("-",
                                style: TextStyle(
                                    color: HexColor.fromHex('#B9B9B9'))),
                          ),
                          onTap: () {
                            print("value of your text");
                          },
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: HexColor.fromHex('#B9B9B9'),
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: HexColor.fromHex('#B9B9B9'),
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                            child: Text(" 1 ",
                                style: TextStyle(
                                    color: HexColor.fromHex('#B9B9B9'))),
                          ),
                          onTap: () {
                            print("value of your text");
                          },
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: HexColor.fromHex('#B9B9B9'),
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(4),
                                    topRight: Radius.circular(4))),
                            padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
                            child: Text(
                              "+",
                              style:
                                  TextStyle(color: HexColor.fromHex('#E59F1A')),
                            ),
                          ),
                          onTap: () {
                            print("value of your text");
                          },
                        ),
                        SizedBox(width: 30),
                        Text(
                          '( 4 Available )',
                          style: TextStyle(
                              color: HexColor.fromHex('#9F9F9F'), fontSize: 11),
                        )
                      ],
                    ),
                  ])
                ])
              ])),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: new Container(
            child: ButtonOrder(
              text: 'Continue',
              textColor: Colors.white,
              backgroundColor: HexColor.fromHex('#FDBA34'),
              paddingHorizontal: 50,
              paddingVertical: 15,
              borderRadius: 3,
              fontWeight: FontWeight.w700,
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.myOrder);
              },
            ),
          )),
    );
  }
}
