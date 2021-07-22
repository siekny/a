import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/rating_category_cubit.dart';
import 'package:htb_mobile/data/models/rating_category.dart';
import 'package:htb_mobile/utils/color_constants.dart';
import 'package:htb_mobile/utils/screen_ratio.dart';
import 'package:htb_mobile/views/widgets/home/header_with_seachbox.dart';
import 'package:htb_mobile/views/widgets/home/recomend_products.dart';
import 'package:htb_mobile/views/widgets/search_bar.dart';
import 'package:htb_mobile/views/widgets/skeleton/product_skeleton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;

    return MultiBlocProvider(
        providers: [
          BlocProvider<RatingCategoryCubit>(
              create: (context) =>
                  RatingCategoryCubit()..getRatingCategories()),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: SearchBar(),
              backgroundColor: Colors.white,
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                      expandedHeight: 220,
                      floating: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: SafeArea(
                        top: false,
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          titlePadding: EdgeInsetsDirectional.only(
                              start: 12, bottom: 0, end: 12, top: 5),
                          background: HeaderWithSearchBox(size: size),
                        ),
                      )),
                ];
              },
              body: BlocProvider<RatingCategoryCubit>(
                create: (context) =>
                    RatingCategoryCubit()..getRatingCategories(),
                child: Stack(
                  children: <Widget>[
                    BlocBuilder<RatingCategoryCubit, RatingCategory>(
                      builder: (context, state) {
                        if (state.result == null) {
                          return ListView.separated(
                              itemBuilder: (ctx, i) {
                                return ProductSkeleton();
                              },
                              separatorBuilder: (ctx, i) => Divider(),
                              itemCount: 3);
                        } else {
                          return Scaffold(
                            body: RefreshIndicator(
                              onRefresh: () async {
                                print("refresh on home screen");
                                _refreshHomeScreen(context, state);
                              },
                              child: SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              state.result.items.length - 1,
                                          itemBuilder: (context, index) {
                                            return RecomendsProduct(
                                                ratingCategoryProduct:
                                                    state.result.items[index]);
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}

void _refreshHomeScreen(BuildContext ctx, var state) async {
  state = null;
  Constant.ratingCategory = null;
  Constant.bannerList = null;
  BlocProvider.of<RatingCategoryCubit>(ctx).getRatingCategories();
}
