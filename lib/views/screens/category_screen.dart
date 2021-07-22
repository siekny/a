import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/categoryCubit.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/category/alibaba_tab_screen.dart';
import 'package:htb_mobile/views/screens/category/taobao_tab_screen.dart';
import 'package:htb_mobile/views/widgets/search_bar.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            bottom: TabBar(
              labelColor: HexColor.fromHex('#515151'),
              indicatorColor: HexColor.fromHex('#E59F1A'),
              tabs: [
                Tab(
                  text: 'Taobao',
                ),
                Tab(
                  text: '1688',
                ),
              ],
            ),
            title: SearchBar(),
          ),
          body: TabBarView(
            children: [
              BlocProvider<CategoryCubit>(
                create: (context) => CategoryCubit()..getCategories(),
                child: TaobaoTabScreen(),
              ),
              BlocProvider<CategoryCubit>(
                create: (context) => CategoryCubit()..getAlibabaCategories(),
                child: AlibabaTabScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
