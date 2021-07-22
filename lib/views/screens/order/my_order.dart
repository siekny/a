import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/data/response/cart_response.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/ButtonField.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class MyOrderScreen extends StatefulWidget {
  List<String> ids;
  MyOrderScreen({this.ids});
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  double sizeBetween;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    sizeBetween = height / 20;

    List<CartResponse> carts;
    List<CartResponse> preview = [];

    BlocProvider.of<CartCubit>(context).viewCart(Constant.token);

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: SubScreenAppBar.getAppBar('My Order'),
        body: BlocBuilder<CartCubit, CartState>(builder: (_, state) {
          if (!(state is CartLoaded))
            return Center(child: CircularProgressIndicator());

          carts = (state as CartLoaded).carts;

          preview.clear();
          print("kdkd" + widget.ids.toString());
          print("kdkd" + carts.toString());
          for (int j = 0; j < carts.length; j++) {
            for (int i = 0; i < widget.ids.length; i++) {
              for (int k = 0; k < carts[j].item.length; k++) {
                if (carts[j].item[k]["cart_id"] == widget.ids[i]) {
                  print(carts[j]);
                  preview.add(carts[j]);
                }
              }
            }
          }

          return SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.sidePadding),
              child: Stack(children: [
                Container(
                  // height: height * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // InkWell(
                      //   onTap: (() =>
                      //       {Navigator.of(context).pushNamed(Routes.newAddress)}),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Padding(
                      //         padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //         child: Text(
                      //           'Delivery Address',
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.add,
                      //         color: Colors.grey,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Card(
                      //     elevation: 4,
                      //     shadowColor: Colors.black26,
                      //     child: ListTile(
                      //       title: Text('Phnom Penh, Sen Sok'),
                      //       subtitle: Text('091 xxx xxx'),
                      //       trailing: Icon(MdiIcons.pencilOutline),
                      //     )),
                      // SizedBox(
                      //   height: 20,
                      // ),

                      // Order
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         'Order',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#3F3F3F'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //       Text(
                      //         '\$ 7.50',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#f00000'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // // Discount
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         'Discount',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#3F3F3F'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //       Text(
                      //         '\$ 7.50',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#f00000'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // // Total
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         'Total',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#3F3F3F'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //       Text(
                      //         '\$ 15.00',
                      //         style: TextStyle(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#f00000'),
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // SizedBox(
                      //   height: 50,
                      // ),

                      // payment
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                children: preview.map((e) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 15),
                                        child: Row(children: [
                                          Icon(Icons.storefront_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${e.supplier}")
                                        ])),
                                    Column(
                                        children: e.item.map((item) {
                                      var quantity = item["quantity"];
                                      var prodImg = (item["color_image_link"]
                                              .toString()
                                              .isNotEmpty)
                                          ? item["color_image_link"]
                                          : item["thumbnail"];
                                      String property = item["color_size"];
                                      String br = "<br><br>";
                                      property = property.replaceAll('\n', br);
                                      return Container(
                                        child: Row(children: <Widget>[
                                          Container(
                                              child: Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      left: 10,
                                                      bottom: 10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child:
                                                      Image.network(prodImg)),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    bottom: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        child: Text(
                                                          item["product_name"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'US \$${item["price"].toString()}',
                                                                style: TextStyle(
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                // crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(''),
                                                                  Row(
                                                                      children: [
                                                                        InkWell(
                                                                          child:
                                                                              Container(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                5,
                                                                                0,
                                                                                5,
                                                                                0),
                                                                            child:
                                                                                Text("Quantity $quantity ", style: TextStyle(color: HexColor.fromHex('#B9B9B9'))),
                                                                          ),
                                                                        )
                                                                      ])
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      InkWell(
                                                        child: Text(
                                                          "see property ➦",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.amber),
                                                        ),
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  new AlertDialog(
                                                                    title: Text(
                                                                        "property"),
                                                                    content:
                                                                        Html(
                                                                      data:
                                                                          """$property""",
                                                                    ),
                                                                  ));
                                                        },
                                                      )
                                                    ]),
                                              )
                                            ],
                                          ))
                                        ]),
                                      );
                                    }).toList())
                                  ],
                                ),
                              );
                            }).toList()),
                          ]),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Payment',
                      //       style: TextStyle(
                      //           fontSize: 18, fontWeight: FontWeight.w700),
                      //     ),
                      //     Text(
                      //       ' ( Optional )',
                      //       style:
                      //           TextStyle(color: HexColor.fromHex('#979797')),
                      //     )
                      //   ],
                      // ),

                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      //   child: Text(
                      //     'upload your payment reciept so that admin would know you’re not a spam',
                      //     style: TextStyle(
                      //         color: HexColor.fromHex('#231F20'), fontSize: 12),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 30,
                      // ),

                      // // drop payment
                      // DottedBorder(
                      //   color: HexColor.fromHex(
                      //       '#E59F1A'), //color of dotted/dash line
                      //   strokeWidth: 1, //thickness of dash/dots
                      //   dashPattern: [5, 5],
                      //   //dash patterns, 10 is dash width, 6 is space width
                      //   child: Container(
                      //       padding: EdgeInsets.all(5),
                      //       alignment: Alignment.center,
                      //       child: InkWell(
                      //           child: Column(
                      //             children: [
                      //               Icon(MdiIcons.cloudDownload,
                      //                   color: HexColor.fromHex('#A8A8A8')),
                      //               SizedBox(height: 8),
                      //               Text(
                      //                 'Drag and drop here',
                      //                 style: TextStyle(
                      //                     color: HexColor.fromHex('#969696'),
                      //                     fontSize: 12),
                      //               ),
                      //               SizedBox(height: 8),
                      //               // InkWell(
                      //               Text('Browse',
                      //                   style: TextStyle(
                      //                       color: HexColor.fromHex('#0085FF'),
                      //                       fontSize: 12)),
                      //               // onTap: null)
                      //             ],
                      //           ),
                      //           onTap: () {
                      //             _uploadPayment(context);
                      //           })),
                      // ),

                      SizedBox(
                        height: 25,
                      ),

                      // submit order
                      InkWell(
                        child: ButtonField(
                            title: 'Place Order',
                            backgroundColor: HexColor.fromHex('#E59F1A'),
                            onPressed: _validateAndSend),
                      ),
                    ],
                  ),
                )
              ]));
        }));
  }

  void _validateAndSend() {
    BlocProvider.of<CartCubit>(context).checkout(Constant.token, widget.ids);
    Navigator.of(context).pushReplacementNamed(Routes.orderSuccess);
  }
}
