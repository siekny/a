import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/categoryCubit.dart';
import 'package:htb_mobile/cubit/search_cubit.dart';
import 'package:htb_mobile/data/models/category.dart';
import 'package:htb_mobile/data/models/sub_category.dart';
import 'package:htb_mobile/utils/font_constants.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/category/third_level_category_screen.dart';
import 'package:htb_mobile/views/widgets/skeleton/skeleton_container.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TaobaoTabScreen extends StatefulWidget {
  @override
  _TaobaoTabScreenState createState() => _TaobaoTabScreenState();
}

class _TaobaoTabScreenState extends State<TaobaoTabScreen> {
  var isHidden;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, Category>(
      builder: (context, category) {
        if (category.categoryInfoList == null) {
          return Center(
            child: ListView.separated(
                itemBuilder: (ctx, i) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: SkeletonContainer.rounded(width: 170, height: 25),
                  );
                },
                separatorBuilder: (ctx, i) => Divider(),
                itemCount: 10),
          );
        }

        return Drawer(
          child: ListView.builder(
              itemCount: category.categoryInfoList.content.length - 2,
              itemBuilder: (context, index) {
                return BlocProvider<SubCategoryCubit>(
                  create: (context) => SubCategoryCubit()
                    ..getSubCategories(
                        category.categoryInfoList.content[index].externalId),
                  child: ExpansionTile(
                    title: Text(
                      category.categoryInfoList.content[index].name,
                      style: TextStyle(
                          fontSize: FontConstants.fontContent,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                    ),
                    onExpansionChanged: (id) {
                      // SubCategoryCubit()
                      //   ..getSubCategories(
                      //       category.categoryInfoList.content[index].externalId);
                      // print(category.categoryInfoList.content[index].name +
                      //     category.categoryInfoList.content[index].externalId);
                    },
                    children: <Widget>[
                      BlocBuilder<SubCategoryCubit, SubCategory>(
                        builder: (context, subCategory) {
                          if (subCategory.categoryInfoList == null) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(35, 15, 30, 15),
                              child: SkeletonContainer.rounded(
                                  width: MediaQuery.of(context).size.width,
                                  height: 20),
                            );
                          }

                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  subCategory.categoryInfoList.content.length,
                              itemBuilder: (contenxt, subIndex) {
                                return new Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: HexColor.fromHex(
                                                  '#ECECEC')))),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Constant.currentCategory = subCategory
                                          .categoryInfoList
                                          .content[subIndex]
                                          .id;
                                      print("before push");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<SearchCubit>(
                                                  create: (context) =>
                                                      SearchCubit()
                                                        ..getRatingCategories(
                                                            subCategory
                                                                .categoryInfoList
                                                                .content[
                                                                    subIndex]
                                                                .id,
                                                            0,
                                                            5,
                                                            "Default order"),
                                                  child:
                                                      ThirdLevelCategoryScreen(),
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      MdiIcons.chevronRight,
                                      size: 18,
                                      color: HexColor.fromHex('#000000'),
                                    ),
                                    label: Text(
                                      subCategory.categoryInfoList
                                          .content[subIndex].name,
                                      style: TextStyle(
                                          fontSize: FontConstants.fontContent,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex('#000000')),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
