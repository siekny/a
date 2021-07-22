import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/utils/check_box_listtile_model.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class CheckoutScreen extends StatefulWidget {
  List<CheckBoxListTileModel> cart;

  CheckoutScreen(this.cart);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<CheckBoxListTileModel> checkBoxListTileModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubScreenAppBar.getAppBar('Checkout'),
      backgroundColor: Colors.white,
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (!(state is CartLoaded))
          return Center(child: CircularProgressIndicator());

        final carts = (state as CartLoaded).carts;
        return SingleChildScrollView(
          child: Column(
            children: carts.map((e) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Text("Supplier : ${e.supplier}"),
                      width: double.infinity,
                      color: Colors.amber,
                      padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    ),
                    Column(
                        children: e.item.map((item) {
                      return Container(
                        child: Row(children: <Widget>[
                          Container(
                              child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.asset(
                                      'assets/images/profile/product.png')),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, bottom: 10),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Text(
                                          'T-Shirt from Hong Kong  askldjf lasdkjf lskadjf lksdflkg jlsdkfjg lksdfj kl',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$ 2.5',
                                                style: TextStyle(
                                                    color: AppColors.red,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 15),
                                              ),
                                              CustomNumberPicker(
                                                initialValue: 1,
                                                maxValue: 100,
                                                minValue: 1,
                                                step: 1,
                                                onValue: (value) {
                                                  print(value.toString());
                                                },
                                              )
                                            ]),
                                      ),
                                      Text('S, Blue',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13)),
                                    ]),
                              )
                            ],
                          ))
                        ]),
                      );
                    }).toList())
                  ]);
            }).toList(),
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Color(0xffeeeeee),
                child: Text("Total : 7.5\$",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54)),
              ),
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
