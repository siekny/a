import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/search_cubit.dart';
import 'package:htb_mobile/data/models/global_items.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/open_card.dart';
import 'package:htb_mobile/views/widgets/searchResult/big_filter_chip.dart';
import 'package:htb_mobile/views/widgets/search_bar.dart';
import 'package:htb_mobile/views/widgets/skeleton/search_skeleton.dart';
import 'package:htb_mobile/views/widgets/skeleton/skeleton_container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ThirdLevelCategoryScreen extends StatefulWidget {
  @override
  _ThirdLevelCategoryScreenState createState() =>
      _ThirdLevelCategoryScreenState();
}

class _ThirdLevelCategoryScreenState extends State<ThirdLevelCategoryScreen> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  var contentList = [];
  int from = 0, to = 5;
  bool isAdded = false;
  int i = 0;
  String order = "Default order";
  String savedParentCategory = Constant.currentCategory;
  List<SubContent> subContentList;
  List<Map<Map<String, String>, List<Map<String, String>>>> filterParent =
      <Map<Map<String, String>, List<Map<String, String>>>>[];

  // GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<String> sorts = [
    "Default order",
    "Price in ascending order",
    "Price in descending order",
    "Total price in ascending order",
    "Total price in descending order",
    "Volume of sales in descending order",
    "Rating of vendor in descending order"
  ];

  String orderText = "Default order";

  void _openDrawer() {
    Constant.selectedProperties.clear();
    _drawerKey.currentState.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Infinity Scroll here
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!isPerformingRequest) {
            _getMoreData(context);
          }
        }
      });

    return BlocBuilder<SearchCubit, GlobalItems>(
      builder: (context, searchResult) {
        if (searchResult.result == null) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 25, 5, 5),
                      child: SkeletonContainer.rounded(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SkeletonContainer.rounded(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SkeletonContainer.rounded(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SkeletonContainer.rounded(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        )),
                  ],
                ),
                Row(children: [
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SearchSkeleton()),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SearchSkeleton()),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SearchSkeleton()),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SearchSkeleton()),
                    ],
                  )
                ])
              ],
            ),
          );
        }

        var newComingList = [];

        if (searchResult.errorCode == 'Ok') {
          newComingList = searchResult.result.items.results.content;
          isPerformingRequest = false;
          contentList.addAll(newComingList);
          newComingList.clear();
        }

        return Scaffold(
          key: _drawerKey,
          appBar: PreferredSize(
            preferredSize: searchResult.result.items.results.totalCount == -1 ||
                    Constant.isSearchbyPhoto
                ? Size.fromHeight(70)
                : Size.fromHeight(120),
            child: searchResult.result.items.results.totalCount == -1
                ? SafeArea(
                    top: true,
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      flexibleSpace: Column(
                        children: <Widget>[
                          SearchBar(),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      leadingWidth: 0,
                      toolbarHeight: 170,
                      elevation: 0,
                    ))
                : SafeArea(
                    top: true,
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      flexibleSpace: Column(
                        children: <Widget>[
                          SearchBar(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 5)
                                  ]),
                              child: Constant.isSearchbyPhoto
                                  ? Row()
                                  : Row(children: [
                                      Expanded(
                                          flex: 4,
                                          child: ActionChip(
                                            avatar: Icon(
                                              Icons.search,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            backgroundColor: Color(0xffededed),
                                            labelStyle: TextStyle(
                                                color: Color(0xff000000),
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold),
                                            label: Text(orderText),
                                            onPressed: () {
                                              _showSheetOrder(
                                                  context, sorts, orderText);
                                            },
                                          )),
                                      searchResult.result.subCategories ==
                                                  null ||
                                              searchResult.result.subCategories
                                                      .content.length ==
                                                  0
                                          ? Expanded(
                                              flex: 0, child: Container())
                                          : Expanded(
                                              flex: 4,
                                              child: ActionChip(
                                                avatar: Icon(
                                                  Icons.category,
                                                  color: Colors.orange,
                                                  size: 15,
                                                ),
                                                backgroundColor:
                                                    Color(0xffededed),
                                                labelStyle: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                label: Text('Categories'),
                                                onPressed: () {
                                                  if (subContentList == null)
                                                    subContentList =
                                                        searchResult
                                                            .result
                                                            .subCategories
                                                            .content;
                                                  _showSheetSubCategories(
                                                      context, subContentList);
                                                },
                                              )),
                                      Expanded(
                                          flex: 4,
                                          child: Builder(
                                              builder: (context) => ActionChip(
                                                  avatar: Icon(
                                                    MdiIcons.filterMenu,
                                                    color: Colors.orange,
                                                    size: 15,
                                                  ),
                                                  backgroundColor:
                                                      Color(0xffededed),
                                                  labelStyle: TextStyle(
                                                      color: Color(0xff000000),
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  label: Text('Filter'),
                                                  onPressed: _openDrawer))),
                                    ]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      leadingWidth: 0,
                      toolbarHeight: 170,
                      elevation: 0,
                    )),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              print("refreshing");
              setState(() {
                from = 0;
                to = 5;
                contentList.clear();
              });
              if (Constant.isSearchbyPhoto) {
                BlocProvider.of<SearchCubit>(context)
                    .getSearchResultbyImage(Constant.photo, 0, 5);
              } else {
                BlocProvider.of<SearchCubit>(context)
                    .getRatingCategories(Constant.currentCategory, 0, 5, order);
              }
            },
            child: searchResult.result.items.results.totalCount == -1
                ? Container(
                    child: Center(
                      child: Image.network(
                          "https://www.iamqatar.qa/assets/images/no-products-found.png"),
                    ),
                  )
                : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    controller: _scrollController,
                    child: Container(
                      // padding: EdgeInsets.all(AppSizes.sidePadding),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: contentList.length + 1,
                            itemBuilder: (context, index) {
                              // print(index);
                              if (index == contentList.length) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return new OpenFlutterCartTile(
                                image: contentList[index].mainPictureUrl,
                                name: contentList[index].title,
                                newPrice:
                                    contentList[index].promotionPrice == null
                                        ? contentList[index]
                                            .price
                                            .convertedPriceList
                                            .internal
                                            .price
                                        : contentList[index]
                                            .promotionPrice
                                            .convertedPriceList
                                            .internal
                                            .price,
                                oldPrice: contentList[index]
                                    .price
                                    .convertedPriceList
                                    .internal
                                    .price,
                                isAvailable: true,
                                vendorScore: checkRatingScoreOfProduct(
                                    contentList[index].vendorScore),
                                productId: contentList[index].id,
                                yuanPrice: contentList[index].price.convertedPriceList.displayedMoneys[1].price,
                                // onAddToCart: () {},
                                // onBuyNow: () {},
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          endDrawer: Drawer(
            child: Center(
                child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          icon: Icon(
                            MdiIcons.restore,
                            color: Colors.white,
                          ),
                          tooltip: "Reset",
                          onPressed: () {
                            _openDrawer();
                          }),
                      title: Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.orange[500],
                      actions: <Widget>[
                        IconButton(
                            icon: Icon(
                              MdiIcons.check,
                              color: Colors.white,
                            ),
                            tooltip: "Filter",
                            onPressed: () {
                              Navigator.of(context).pop();
                              _filterProperties(context, searchResult);
                              setState(() {
                                contentList.clear();
                                Constant.selectedProperties.clear();
                              });
                            }),
                      ],
                    ),
                    body: searchResult.result.items.results.totalCount == -1 ||
                            Constant.isSearchbyPhoto
                        ? new Row()
                        : new Row(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: new ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: searchResult.result
                                        .searchProperties.contentP.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return new BigFilterChip(
                                          contentP: searchResult
                                              .result
                                              .searchProperties
                                              .contentP[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ))),
          ),
          // Disable opening the end drawer with a swipe gesture.
          endDrawerEnableOpenDragGesture: true,
        );
      },
    );
  }

  void _getMoreData(BuildContext ctx) async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      from += 5;
      print("from" + from.toString());
      checkTitlteOrCategory(ctx);
    }
  }

  List<Widget> checkRatingScoreOfProduct(int vendorScore) {
    List<Widget> vendorScoreIconList = <Widget>[];
    vendorScoreIconList.clear();
    if (vendorScore <= 5) {
      for (var i = 1; i <= vendorScore; i++) {
        vendorScoreIconList.add(
            Icon(MdiIcons.star, size: 18, color: HexColor.fromHex('#4cae4c')));
      }
    }
    if (vendorScore > 5 && vendorScore <= 10) {
      for (var i = 1; i <= vendorScore - 5; i++) {
        vendorScoreIconList
            .add(Icon(MdiIcons.star, size: 18, color: Colors.red));
      }
    }
    if (vendorScore > 10 && vendorScore <= 15) {
      for (var i = 1; i <= vendorScore - 10; i++) {
        vendorScoreIconList.add(Icon(MdiIcons.diamond,
            size: 18, color: HexColor.fromHex('#FFCC00')));
      }
    }
    if (vendorScore > 15 && vendorScore <= 20) {
      for (var i = 1; i <= vendorScore - 15; i++) {
        vendorScoreIconList.add(
            Icon(MdiIcons.heart, size: 18, color: HexColor.fromHex('#c81b1b')));
      }
    }
    if (vendorScore > 20 && vendorScore <= 25) {
      for (var i = 1; i <= vendorScore - 20; i++) {
        vendorScoreIconList.add(Icon(MdiIcons.diamond,
            size: 18, color: HexColor.fromHex('#007bff')));
      }
    }

    return vendorScoreIconList;
  }

  void _showSheetOrder(ctx, sorts, orderText) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              color: Colors.orange[100],
              child: ListView.builder(
                controller: controller,
                itemCount: sorts.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(sorts[i]),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      orderText = sorts[i];
                      order = sorts[i];
                      contentList.clear();
                    });
                    checkTitlteOrCategory(ctx);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSheetSubCategories(ctx, contentLists) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              color: Colors.orange[100],
              child: ListView.builder(
                controller: controller,
                itemCount: contentLists.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(contentLists[i].name),
                  onTap: () {
                    Navigator.pop(context);
                    Constant.currentCategory = contentLists[i].id;
                    setState(() {
                      contentList.clear();
                    });
                    checkTitlteOrCategory(ctx);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _filterProperties(ctx, GlobalItems searchResult) {
    from = 0;
    for (var i = 0;
        i < searchResult.result.searchProperties.contentP.length;
        i++) {
      for (var j = 0;
          j < searchResult.result.searchProperties.contentP[i].values.length;
          j++) {
        if (Constant.selectedProperties.contains(
            searchResult.result.searchProperties.contentP[i].values[j].name)) {
          Constant.filterProperties.add({
            searchResult.result.searchProperties.contentP[i].id:
                searchResult.result.searchProperties.contentP[i].values[j].id
          });
        }
      }
    }
    print(Constant.filterProperties);
    checkTitlteOrCategory(ctx);
  }

  void checkTitlteOrCategory(ctx) {
    if (Constant.isSearchbyPhoto) {
      BlocProvider.of<SearchCubit>(context)
          .getSearchResultbyImage(Constant.photo, from, 5);
    } else {
      if (Constant.currentCategory != null) {
        BlocProvider.of<SearchCubit>(ctx)
            .getRatingCategories(Constant.currentCategory, from, 5, order);
      } else {
        BlocProvider.of<SearchCubit>(ctx)
            .getRatingCategories(Constant.currentSearch, from, 5, order);
      }
    }
  }
}
