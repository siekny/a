import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/rating_category_cubit.dart';
import 'package:htb_mobile/data/models/rating_category.dart';
import '../../../utils/color_constants.dart';

class RecommendedCategory extends StatelessWidget {
  const RecommendedCategory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<RatingCategoryCubit, RatingCategory>(
        builder: (context, ratingCategoryProduct) {
          if (ratingCategoryProduct.result == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Widget> productlist = <Widget>[];
          var rec = ratingCategoryProduct.result.categories;
          var recommendCategories = rec[0].result;
          var imageUrl;

          for (var i = 0; i < recommendCategories.contentc.length; i++) {
            imageUrl = recommendCategories.contentc[i].iconImageUrl == null
                ? "assets/images/profile/product.png"
                : recommendCategories.contentc[i].iconImageUrl;

            productlist.add(RecommendedCategoryCard(
              image: imageUrl,
              title: recommendCategories.contentc[i].name,
              press: () {},
            ));
          }
          return Row(
            children: productlist,
          );
        },
      ),
    );
  }
}

class RecommendedCategoryCard extends StatelessWidget {
  const RecommendedCategoryCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: ColorConstants.kDefaultPadding,
        top: ColorConstants.kDefaultPadding / 2,
        bottom: ColorConstants.kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.network(
            image,
            fit: BoxFit.cover,
            width: 1000.0,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Text('Check your internet connection');
            },
          ),
          GestureDetector(
            onTap: press,
            child: Container(
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
                    color: ColorConstants.primaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n",
                            style: Theme.of(context).textTheme.button),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
