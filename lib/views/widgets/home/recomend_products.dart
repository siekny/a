import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/data/models/rating_category.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';
import 'package:htb_mobile/views/widgets/home/title_with_more_bbtn.dart';
import '../../../utils/color_constants.dart';

class RecomendsProduct extends StatelessWidget {
  Items ratingCategoryProduct;
  RecomendsProduct({Key key, @required this.ratingCategoryProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> productlist = <Widget>[];
    Items ratingProduct = ratingCategoryProduct;
    var recommendProduct = ratingProduct.results.content;
    for (var i = 0; i < ratingProduct.results.content.length; i++) {
      productlist.add(RecomendProductCard(
        image: recommendProduct[i].mainPictureUrl,
        title: recommendProduct[i].title,
        discountPrice: recommendProduct[i].promotionPrice == null
            ? recommendProduct[i].price.convertedPriceList.internal.price
            : recommendProduct[i]
                .promotionPrice
                .convertedPriceList
                .internal
                .price,
        price: recommendProduct[i].price.convertedPriceList.internal.price,
        yuanPrice: recommendProduct[i]
            .price
            .convertedPriceList
            .displayedMoneys[1]
            .price,
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ProductDetailCubit>(
                            create: (context) => ProductDetailCubit()),
                        BlocProvider<ProductDetailCubit>(
                          create: (context) => ProductDetailCubit()
                            ..getProductDetail(recommendProduct[i].id),
                        ),
                        BlocProvider<WishListCubit>(
                          create: (context) => WishListCubit()..getWishLists(),
                        ),
                      ],
                      child: ProductDetailScreen(
                        productId: recommendProduct[i].id,
                      ),
                    )),
          );
        },
      ));
    }

    return Column(
      children: [
        TitleWithMoreBtn(title: ratingProduct.name),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productlist,
            ))
      ],
    );
  }
}

class RecomendProductCard extends StatelessWidget {
  const RecomendProductCard({
    Key key,
    this.image,
    this.title,
    this.discountPrice,
    this.price,
    this.yuanPrice,
    this.press,
  }) : super(key: key);

  final String image, title;
  final double discountPrice;
  final double price;
  final Function press;
  final double yuanPrice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(
          left: ColorConstants.kDefaultPadding,
          top: ColorConstants.kDefaultPadding / 2,
          bottom: ColorConstants.kDefaultPadding * 1,
        ),
        width: size.width * 0.4,
        child: GestureDetector(
          onTap: press,
          child: Column(
            children: <Widget>[
              Container(
                  width: 1000,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: HexColor.fromHex('#f5f5f5'))),
                  child: FadeInImage(
                    image: NetworkImage(image),
                    placeholder: AssetImage('assets/images/no_product.png'),
                    fit: BoxFit.cover,
                  )),
              Container(
                padding: EdgeInsets.all(ColorConstants.kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.black12.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "$title\n",
                                  style: Theme.of(context).textTheme.button),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$discountPrice\$".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.red[800]),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: "$price\$",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black12,
                                ),
                              )
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$yuanPrice\元".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                        color: ColorConstants.primaryColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
