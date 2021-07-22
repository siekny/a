import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/cubit/edit_cart_cubit.dart';
import 'package:htb_mobile/data/response/cart_response.dart';
import 'package:htb_mobile/utils/check_box_listtile_model.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/order/my_order.dart';
import '../../../config/constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CheckBoxListTileModel> checkBoxListTileModel = <CheckBoxListTileModel>[];
  int reset = 1;
  List<CartResponse> carts;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).viewCart(Constant.token);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style:
              TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold),
        ),
        elevation: 0.3,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: AppColors.orange, //change your color here
        ),
      ),
      backgroundColor: Color(0xffF2F3F7),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (!(state is CartLoaded))
          return Center(child: CircularProgressIndicator());

        if (state is CartEdited) {
          Navigator.pop(context);
        } else if (state is EditCartError) {
          Toast.show("something's wrong", context,
              backgroundColor: Colors.red, duration: 3, gravity: Toast.CENTER);
        }

        carts = (state as CartLoaded).carts;
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<CartCubit>(context).viewCart(Constant.token);
            carts = (state as CartLoaded).carts;
          },
          child: (carts.length == 0)
              ? Center(
                  child: Text("Cart Empty"),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Color(0xffF2F3F7),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 25),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon((reset % 2 == 0)
                                              ? Icons.check_box
                                              : Icons
                                                  .check_box_outline_blank_rounded),
                                          color: (reset % 2 == 0)
                                              ? Colors.amber
                                              : Colors.black12,
                                          onPressed: () {
                                            setState(() {
                                              reset++;
                                              if (reset % 2 == 0) {
                                                resetStatus(true);
                                              } else {
                                                resetStatus(false);
                                              }
                                            });
                                          }),
                                      Text("select all")
                                    ],
                                  ),
                                ),
                              ]),
                          Column(
                            children: carts.map((e) {
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
                                      checkBoxListTileModel.add(
                                          CheckBoxListTileModel(
                                              item["cart_id"], false));
                                      String property = item["color_size"];
                                      String br = "<br><br>";
                                      property = property.replaceAll('\n', br);
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
                                        secondaryActions: <Widget>[
                                          // Container(
                                          //   padding: EdgeInsets.only(bottom: 7),
                                          //   color: Colors.black54,
                                          //   height: double.infinity,
                                          //   child: Column(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       SizedBox(
                                          //         child: IconButton(icon: Icon(productStatus(item["cart_id"])?Icons.check_box_rounded:Icons.check_box_outline_blank_sharp),color: productStatus(item["cart_id"])? Colors.amber:Colors.white, onPressed:(){
                                          //           itemChange(productStatus(item["cart_id"]),item["cart_id"]);
                                          //         }),
                                          //         height: 30,
                                          //       ),
                                          //       Text("Check out",style: TextStyle(fontSize: 10,color: Colors.white),)
                                          //     ],
                                          //   ),
                                          // ),
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () {
                                              showConfirmDialog(
                                                  context, item["cart_id"]);
                                            },
                                          ),
                                        ],
                                        child: Container(
                                          child: Row(children: <Widget>[
                                            Container(
                                                child: Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(productStatus(
                                                            item["cart_id"])
                                                        ? Icons
                                                            .check_box_rounded
                                                        : Icons
                                                            .check_box_outline_blank_sharp),
                                                    color: productStatus(
                                                            item["cart_id"])
                                                        ? Colors.amber
                                                        : Colors.black12,
                                                    onPressed: () {
                                                      itemChange(
                                                          productStatus(
                                                              item["cart_id"]),
                                                          item["cart_id"]);
                                                    }),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                            item[
                                                                "product_name"],
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
                                                                      color: AppColors
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
                                                                              decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: HexColor.fromHex('#B9B9B9'),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), topLeft: Radius.circular(4))),
                                                                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                              child: Text("-", style: TextStyle(color: HexColor.fromHex('#B9B9B9'))),
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              if (int.parse(item["quantity"]) == 1) {
                                                                                Toast.show("Quantity can not be 0", context);
                                                                              } else {
                                                                                var result = await BlocProvider.of<EditCartCubit>(context).updateCart(int.parse(item["quantity"]), item["cart_id"], false, double.parse(item["price"]));

                                                                                setState(() {
                                                                                  quantity = result.quantity.toString();
                                                                                });
                                                                              }
                                                                            },
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Container(
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
                                                                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                              child: Text(" $quantity ", style: TextStyle(color: HexColor.fromHex('#B9B9B9'))),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    width: 1,
                                                                                    color: HexColor.fromHex('#B9B9B9'),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), topRight: Radius.circular(4))),
                                                                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                              child: Text(
                                                                                "+",
                                                                                style: TextStyle(color: HexColor.fromHex('#B9B9B9')),
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              var result = await BlocProvider.of<EditCartCubit>(context).updateCart(int.parse(item["quantity"]), item["cart_id"], true, double.parse(item["price"]));

                                                                              setState(() {
                                                                                quantity = result.quantity.toString();
                                                                              });
                                                                            },
                                                                          ),
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
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
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
                                        ),
                                      );
                                    }).toList())
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ]),
                  ),
                ),
        );
      }),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.center,
            //     color: Color(0xffeeeeee),
            //     child: Text("Total : 7.5\$", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.black54)),
            //   ),
            // ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (checkBoxListTileModel
                          .where((e) => e.isCheck == true)
                          .length >
                      0) {
                    // print(checkBoxListTileModel.where((e)=>e.isCheck==true).map((ele)=>ele.productId).toList().runtimeType);
                    checkout(
                        Constant.token,
                        checkBoxListTileModel
                            .where((e) => e.isCheck == true)
                            .map((ele) => ele.productId)
                            .toList());
                    // BlocProvider.of<CartCubit>(context).viewCart(Constant.token);
                  } else {
                    Toast.show("please select product to checkout", context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xffE59F1A),
                  child: Text("CHECK OUT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkout(String token, List<String> ids) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider<CartCubit>(
              create: (context) => CartCubit(),
              child: MyOrderScreen(ids: ids),
            )));
  }

  bool productStatus(String id) {
    return checkBoxListTileModel.firstWhere((e) => e.productId == id).isCheck;
  }

  void itemChange(bool val, String id) {
    setState(() {
      checkBoxListTileModel.firstWhere((e) => e.productId == id).isCheck = !val;
    });
  }

  void setStatus(bool val, String id) {
    setState(() {
      checkBoxListTileModel.firstWhere((e) => e.productId == id).isCheck = val;
    });
  }

  showConfirmDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        removeItem(id);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove from cart"),
      content: Text("Would you like to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void removeItem(String id) {
    setState(() {
      BlocProvider.of<CartCubit>(context).deleteCart(Constant.token, id);
      BlocProvider.of<CartCubit>(context).viewCart(Constant.token);
    });
  }

  void resetStatus(bool status) {
    for (int i = 0; i < checkBoxListTileModel.length; i++) {
      setState(() {
        checkBoxListTileModel[i].isCheck = status;
      });
    }
  }

  bool _isButtonTapped = false;

  void updatingItem(String id) async {
    // await launch(_url);
  }
}
