import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/data/models/ordered_history_detail.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';
import 'package:htb_mobile/views/widgets/show_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardOrderHistoryDetail extends StatefulWidget {
  final ListItems item;
  final String watingOrder;
  CardOrderHistoryDetail({this.item, this.watingOrder});
  @override
  _CardOrderHistoryDetailState createState() => _CardOrderHistoryDetailState();
}

class _CardOrderHistoryDetailState extends State<CardOrderHistoryDetail> {
  bool showPopup = false;

  @override
  Widget build(BuildContext context) {
    // var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    String property = widget.item.colorSize;
    property = property.replaceAll('[{', "").replaceAll('}]', "");
    return Card(
        elevation: 4,
        shadowColor: Colors.black26,
        child: Container(
            padding: EdgeInsets.all(AppSizes.sidePadding),
            child: InkWell(
              child: Stack(children: <Widget>[
                Row(children: <Widget>[
                  Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height / 6,
                      child: FadeInImage(
                        image: NetworkImage(
                          '${widget.item?.thumbnail}',
                        ),
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/images/no_product.png'),
                      )),
                  Container(
                      width: width - 150,
                      padding: EdgeInsets.only(left: AppSizes.sidePadding),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.item.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Code : ${widget.item?.productCode}',
                              style:
                                  TextStyle(color: HexColor.fromHex('#7F7C7B')),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\$ ${widget.item?.price}',
                              style: TextStyle(
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 5),
                            // Text(
                            //   """${body['colour']}""",
                            // ),
                            Html(data: '$property'),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '( ${widget.item?.quantity} )',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Total: ${widget.item?.amount} \$',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            widget.watingOrder != null
                                ? Row(
                                    children: [
                                      Icon(
                                        MdiIcons.store,
                                        color: Colors.black54,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(widget.watingOrder)
                                    ],
                                  )
                                : Text('')
                          ])),
                ]),
              ]),
              onTap: () {
                widget.item.productCode == null || widget.item.productCode == ''
                    ? ShowDialog().showcontent(context, 'Empty',
                        'Sorry, The product code is nothing !!!')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<ProductDetailCubit>(
                                      create: (context) => ProductDetailCubit()
                                        ..getProductDetail(
                                            widget.item.productCode),
                                    ),
                                    BlocProvider<WishListCubit>(
                                      create: (context) =>
                                          WishListCubit()..getWishLists(),
                                    ),
                                  ],
                                  child: ProductDetailScreen(
                                    productId: widget.item.productCode,
                                  ),
                                )),
                      );
              },
            )));
  }
}
