import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/data/models/product_detail.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/cart/cart_screen.dart';
import 'package:htb_mobile/views/screens/order/my_order.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path/path.dart';
import 'package:html/parser.dart';
import 'package:toast/toast.dart';
import 'package:html_unescape/html_unescape.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  ProductDetailScreen({this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double sizeBetween;
  int _current = 0;
  ProductDetailCubit _cartCubit;
  bool isFavoredTemp = false;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    var height = MediaQuery.of(context).size.height;
    sizeBetween = height / 20;
    _cartCubit = BlocProvider.of<ProductDetailCubit>(context);

    ProductDetail productDetail;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar.getAppBar('Product Detail'),
      body: BlocBuilder<ProductDetailCubit, ProductDetail>(
        builder: (ctx, product) {
          print(
              'object_detail ${product?.isFavored} ${product?.title} ${product?.wishlistId}');
          if (product == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          productDetail = product;

          var unescape = HtmlUnescape();
          var text = unescape.convert(product.description);

          return SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            minimum: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    items: product.pictures.map((e) {
                      return imageItem(e["Url"], context);
                    }).toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        height: 400,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: product.pictures.map((e) {
                      int index = product.pictures.indexWhere((el) {
                        return el["Url"] == e["Url"];
                      });
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color(0xffFF771C)
                              : const Color(0XFFEBF0FF),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: c_width,
                                child: Text(
                                  "${product.title}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              product.isFavored
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: HexColor.fromHex('#ffFF771C'),
                                      ),
                                      onPressed: () {
                                        Constant.getToken() == null
                                            ? Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext ctx) =>
                                                            Login()))
                                            : _removeWishlist(product,
                                                product.wishlistId, context);
                                      })
                                  : IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: HexColor.fromHex('#ffFF771C'),
                                      ),
                                      onPressed: () {
                                        Constant.getToken() == null
                                            ? Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext ctx) =>
                                                            Login()))
                                            : _addWishlist(product, context);
                                      })
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${product.price}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: const Color(0xffFF0000),
                                    fontWeight: FontWeight.bold),
                              ),
                              product.oldPrice != null
                                  ? Text(
                                      "\$ ${product.oldPrice}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xffB9B9B9)),
                                    )
                                  : Text(""),
                              product.vendor != 0.0
                                  ? RatingBarIndicator(
                                      rating: product.vendor,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      direction: Axis.horizontal,
                                    )
                                  : Text(""),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select Size & Color ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  icon: Icon(Icons.arrow_right,
                                      size: 40, color: const Color(0xffFF771C)),
                                  onPressed: () {
                                    Navigator.of(ctx).pushNamed(
                                        Routes.productDetailConfig,
                                        arguments: {
                                          "property": product.properties
                                        });
                                  })
                            ],
                          ),
                          // Text("Description",style: TextStyle(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.bold
                          // ),),
                          Container(
                            child: Html(
                              data: "${text}",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "The radiance lives on in the Nike Air Force 1 ’07, the b-ball OG that puts a fresh spin on what you know best: crisp leather in an all-white colorway for a statement look on and off the court. ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),

            // child:
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  if (Constant.selectedConfig.isEmpty) {
                    Toast.show("Please Select Configuration", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  } else {
                    String colorSize = '';
                    for (int i = 0; i < Constant.selectedConfig.length; i++) {
                      colorSize += Constant.selectedConfig[i].keys.first +
                          " : " +
                          Constant.selectedConfig[i].values.first +
                          "\n";
                    }
                    productDetail.colorSize = colorSize;
                    productDetail.quantity = Constant.qty;
                    if (Constant.token == null) {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.register);
                    } else {
                      var added =
                          _cartCubit.addCart(Constant.token, productDetail);
                      added.then((value) {
                        if (value != 0) {
                          Constant.selectedConfig.clear();
                          Constant.qty = 1;
                          Toast.show("product is added to cart", context);
                        } else {
                          Toast.show(
                              "There are problem when add to cart", context);
                        }
                      });
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xffFDBA2D),
                  child: Text("Add to cart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (Constant.selectedConfig.isEmpty) {
                    Toast.show("Please Select Configuration", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  } else {
                    String colorSize = '';
                    for (int i = 0; i < Constant.selectedConfig.length; i++) {
                      colorSize += Constant.selectedConfig[i].keys.first +
                          " : " +
                          Constant.selectedConfig[i].values.first +
                          "\n";
                    }
                    productDetail.colorSize = colorSize;
                    productDetail.quantity = Constant.qty;

                    if (Constant.token == null) {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.register);
                    } else {
                      var added =
                          _cartCubit.addCart(Constant.token, productDetail);
                      added.then((value) {
                        if (value != 0) {
                          Constant.selectedConfig.clear();
                          Constant.qty = 1;
                          checkout(Constant.token, [value.toString()], context);
                        } else {
                          Toast.show("Server Error Please try again", context);
                        }
                      });
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xffE59F1A),
                  child: Text("BUY NOW",
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

  // void addItem(ProductDetail pro, BuildContext con) {
  //   BlocProvider.of<CartCubit>(con).addCart(Constant.token, pro);
  //
  //   // Constant.selectedConfig.clear();
  //
  // }

  void checkout(String token, List<String> ids, BuildContext con) {
    Navigator.of(con).push(MaterialPageRoute(
        builder: (context) => BlocProvider<CartCubit>(
              create: (context) => CartCubit(),
              child: MyOrderScreen(ids: ids),
            )));
  }

  Widget imageItem(String url, BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.network(
              url,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

// add product to wishlist
  void _addWishlist(ProductDetail product, BuildContext context) {
    print('state $isFavoredTemp');
    var jsonProduct = jsonEncode(<String, String>{
      'product_code': '${product.id}',
      'product_name': '${product.title}',
      'color_size': '${product.colorSize}',
      'color_image_link': '${product.colorImageLink}',
      'price': '${product.price}',
      'amount': '${product.amount}',
      'supplyer': '${product.supplyer}',
      'thumbnail_url': '${product.thumnail_url}',
      'product_url': '${product.product_url}',
      'token': '${Constant.getToken()}'
    });

    print('product object $jsonProduct');

    BlocProvider.of<WishListCubit>(context)
        .addWishlist(jsonProduct, product.id);
    setState(() {
      product.isFavored = true;
    });
  }

  void _removeWishlist(
      ProductDetail product, String wishlistId, BuildContext context) {
    print('state $isFavoredTemp');
    print('wishlistId $wishlistId');
    BlocProvider.of<WishListCubit>(context)
        .removeWishlishInDetail(wishlistId, product.id);
    setState(() {
      product.isFavored = false;
    });
  }
}
