import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

class CardOrderDetail extends StatefulWidget {
  // final CartItem item;
  final Function(int quantity) onChangeQuantity;

  const CardOrderDetail({
    Key key,
    // @required this.item,
    @required this.onChangeQuantity,
  }) : super(key: key);

  @override
  _CardOrderDetailState createState() => _CardOrderDetailState();
}

class _CardOrderDetailState extends State<CardOrderDetail> {
  bool showPopup = false;

  @override
  Widget build(BuildContext context) {
    // var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return Card(
        elevation: 4,
        shadowColor: Colors.black26,
        child: Container(
            padding: EdgeInsets.all(AppSizes.sidePadding),
            child: Stack(children: <Widget>[
              Row(children: <Widget>[
                Container(
                    width: 100,
                    child: Image.asset('assets/images/profile/product.png')),
                Container(
                    width: width - 150,
                    padding: EdgeInsets.only(left: AppSizes.sidePadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'T-Shirt from Hong Kong ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$ 2.5',
                            style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                          ),
                          SizedBox(height: 12),
                          Text('S, Blue',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '(2)',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Total: 5, 000 \$',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ]))
              ])
            ])));
  }
}
