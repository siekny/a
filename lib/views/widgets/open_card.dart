import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/utils/color_constants.dart';
import 'package:htb_mobile/utils/font_constants.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';

class OpenFlutterCartTile extends StatefulWidget {
  final String image;
  final String name;
  final double newPrice;
  final double oldPrice;
  final bool isAvailable;
  final List<Widget> vendorScore;
  final String productId;
  final double yuanPrice;

  // final Function() onAddToCart;
  // final Function() onBuyNow;

  const OpenFlutterCartTile({
    Key key,
    @required this.image,
    @required this.name,
    @required this.newPrice,
    @required this.oldPrice,
    @required this.isAvailable,
    @required this.vendorScore,
    @required this.productId,
    @required this.yuanPrice,
    // @required this.onAddToCart,
    // @required this.onBuyNow
  }) : super(key: key);

  @override
  _OpenFlutterCartTileState createState() => _OpenFlutterCartTileState();
}

class _OpenFlutterCartTileState extends State<OpenFlutterCartTile> {
  bool showPopup = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(bottom: AppSizes.sidePadding),
        child: Container(
            padding: EdgeInsets.all(AppSizes.linePadding * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.lightGray.withOpacity(0.3),
                      blurRadius: AppSizes.imageRadius,
                      offset: Offset(0.0, AppSizes.imageRadius))
                ],
                color: AppColors.white),
            child: Stack(children: <Widget>[
              Row(
                children: <Widget>[
                  // product's image

                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider<ProductDetailCubit>(
                                      create: (context) => ProductDetailCubit()
                                        ..getProductDetail(
                                            this.widget.productId),
                                    ),
                                    BlocProvider<WishListCubit>(
                                      create: (context) =>
                                          WishListCubit()..getWishLists(),
                                    ),
                                  ],
                                  child: ProductDetailScreen(
                                    productId: this.widget.productId,
                                  ),
                                )),
                      );
                    },
                    child: Container(
                        width: 104, child: Image.network(this.widget.image)),
                  ),
                  // product's content
                  Container(
                      padding: EdgeInsets.only(left: AppSizes.sidePadding),
                      // width: width - 130,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: width - 130,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${this.widget.name}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      FontConstants.fontContent,
                                                  color: HexColor.fromHex(
                                                      '#231F20'),
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${this.widget.newPrice}\$',
                                                    style: TextStyle(
                                                        color: HexColor.fromHex(
                                                            '#F9003E'),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: FontConstants
                                                            .fontContent),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    '${this.widget.oldPrice}\$',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children:
                                                    this.widget.vendorScore,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${this.widget.yuanPrice}' +
                                                    "元",
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .primaryColor,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              // Text(
                                              //   '2 in stock',
                                              //   style: TextStyle(
                                              //       color: HexColor.fromHex(
                                              //           '#6B9B67'),
                                              //       fontSize: 14),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     TextButton.icon(
                                          //       onPressed: () {
                                          //         print('Add to cart');
                                          //       },
                                          //       icon: Icon(
                                          //         MdiIcons.cartArrowDown,
                                          //         size: 18,
                                          //       ),
                                          //       label: Text('Add to cart'),
                                          //       style: ButtonStyle(
                                          //           foregroundColor:
                                          //               MaterialStateProperty.all(
                                          //                   HexColor.fromHex(
                                          //                       '#E59F1A')),
                                          //           textStyle: MaterialStateProperty.all(
                                          //               TextStyle(
                                          //                   fontSize: FontConstants
                                          //                       .fontContent)),
                                          //           shape: MaterialStateProperty.all<
                                          //                   RoundedRectangleBorder>(
                                          //               RoundedRectangleBorder(
                                          //                   borderRadius:
                                          //                       BorderRadius.circular(18.0),
                                          //                   side: BorderSide(color: HexColor.fromHex('#E59F1A'))))),
                                          //     ),
                                          //     OutlinedButton(
                                          //       onPressed: () {
                                          //         print('Buy Now');
                                          //       },
                                          //       child: Text('Buy now'),
                                          //       style: ButtonStyle(
                                          //           backgroundColor:
                                          //               MaterialStateProperty.all(
                                          //                   HexColor.fromHex(
                                          //                       '#E59F1A')),
                                          //           foregroundColor:
                                          //               MaterialStateProperty.all(
                                          //                   HexColor.fromHex(
                                          //                       '#ffffff')),
                                          //           textStyle: MaterialStateProperty.all(TextStyle(
                                          //               fontSize: FontConstants
                                          //                   .fontContent)),
                                          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          //               RoundedRectangleBorder(
                                          //                   borderRadius: BorderRadius.circular(18.0),
                                          //                   side: BorderSide(color: HexColor.fromHex('#E59F1A'))))),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      )),
                                ]),
                          ]))
                ],
              ),
            ])));
  }
}
