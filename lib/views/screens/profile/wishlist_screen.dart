import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/data/models/wishlist.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/utils/font_constants.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  @override
  WishlistScreenState createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: SubScreenAppBar.getAppBar('Wishlist'),
        backgroundColor: Colors.white,
        body: Constant.getToken() == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => Login()))
            : BlocBuilder<WishListCubit, Wishlist>(
                builder: (context, wishlists) {
                  if (wishlists == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (wishlists.countItem == "0") {
                    return Center(
                      child: Text("No Wishlist Yet"),
                    );
                  }
                  return RefreshIndicator(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: wishlists?.listCarts?.length,
                          itemBuilder: (context, index) {
                            return listwishlist(wishlists, index, width);
                          }),
                      onRefresh: () async {
                        await Future.delayed(Duration(milliseconds: 1000));
                        Provider.of<WishListCubit>(context, listen: false)
                            .getWishLists();
                      });
                },
              ));
  }

  Widget listwishlist(wishlists, index, width) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: wishlists?.listCarts[index]?.items?.length,
            itemBuilder: (context, indexItem) {
              return cardWishlist(
                  width, wishlists?.listCarts[index].items[indexItem]);
            })
      ],
    );
  }

  Widget cardWishlist(double width, Items item) {
    return InkWell(
        onTap: () {
          print('go to detail ${item.productCode}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<ProductDetailCubit>(
                              create: (context) => ProductDetailCubit()),
                          BlocProvider<ProductDetailCubit>(
                            create: (context) => ProductDetailCubit()
                              ..getProductDetail(item.productCode),
                          ),
                          BlocProvider<WishListCubit>(
                            create: (context) =>
                                WishListCubit()..getWishLists(),
                          ),
                        ],
                        child: ProductDetailScreen(
                          productId: item.productCode,
                        ),
                      )));
        },
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
                  Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: HexColor.fromHex('#f5f5f5'))),
                      child: FadeInImage(
                        image: NetworkImage(item?.thumbnail),
                        placeholder: AssetImage('assets/images/no_product.png'),
                        fit: BoxFit.cover,
                      )),

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
                                      width: width - 150,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item?.productName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      FontConstants.fontContent,
                                                  color: HexColor.fromHex(
                                                      '#231F20'),
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(height: 8),
                                          Text(
                                            'Code : ${item?.productCode}',
                                            style: TextStyle(
                                                color: HexColor.fromHex(
                                                    '#7F7C7B')),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '\$ ${item?.price}',
                                            style: TextStyle(
                                                color:
                                                    HexColor.fromHex('#F9003E'),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    FontConstants.fontContent),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextButton(
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            onPressed: () {
                                              _removeWishlistClicked(
                                                  item?.whistlistId,
                                                  item?.productCode);
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red),
                                                textStyle: MaterialStateProperty.all(
                                                    TextStyle(
                                                        fontSize: FontConstants
                                                            .fontContent)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0),
                                                        side: BorderSide(color: Colors.red)))),
                                          ),
                                        ],
                                      )),
                                ]),
                          ]))
                ],
              ),
            ])));
  }

  void _removeWishlistClicked(wishilistId, code) {
    BlocProvider.of<WishListCubit>(context).removeOneWishlist(wishilistId);
    // show snackbar message
    // try {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text(
    //         'Product code [$code] is removed from wishlist successfully ...'),
    //   ));
    // } on Exception catch (e, s) {
    //   print(s);
    // }
  }
}
