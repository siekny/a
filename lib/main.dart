import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/utils/httpOverrides.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/cubit/edit_cart_cubit.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/cubit/postcubit.dart';
import 'package:htb_mobile/data/repository.dart';
import 'package:htb_mobile/views/home/PostView.dart';
import 'package:htb_mobile/views/navigation/main_bottom_nav.dart';
import 'package:htb_mobile/views/screens/cart/cart_screen.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_config_screen.dart';
import 'package:htb_mobile/views/screens/category/third_level_category_screen.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';
import 'package:htb_mobile/views/screens/order/my_order.dart';
import 'package:htb_mobile/views/screens/order/option_screen.dart';
import 'package:htb_mobile/views/screens/order/order_success.dart';
import 'package:htb_mobile/views/screens/profile/edit_profile_screen.dart';
import 'package:htb_mobile/views/screens/profile/new_delivery_address.dart';
import 'package:htb_mobile/views/screens/profile/order_detail.dart';
import 'package:htb_mobile/views/screens/profile/profile_order_screen.dart';
import 'package:htb_mobile/views/screens/profile/wishlist_screen.dart';
import 'package:htb_mobile/views/screens/qrscan/qrscan.dart';
import 'package:htb_mobile/views/screens/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/screens/profile/tracking_order_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  Constant.token = token;
  print(token);
  runApp(MaterialApp(home: Main()));
  // runApp(MaterialApp(
  //   home: MyApp(),
  // ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Repository repository = Repository();

  CartCubit cartCubit = CartCubit();

  @override
  Widget build(BuildContext context) {
    final productDetailCubit = ProductDetailCubit();
    HttpOverrides.global = new MyHttpOverrides();
    return MaterialApp(
        title: 'HTB Mobile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PostCubit>(
              create: (context) => PostCubit()..getPosts(),
            ),
            BlocProvider<ProductDetailCubit>(
              create: (context) => productDetailCubit,
            ),
            BlocProvider<CartCubit>(
              create: (context) => CartCubit(),
            ),
            BlocProvider(
              create: (BuildContext context) => EditCartCubit(
                repository: repository,
                cartCubit: cartCubit,
              ),
            )
          ],
          child: MainBottomNavigation(),
        ),
        routes: _registerRoutes());
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      Routes.profile: (context) => EditProfileScreen(),
      Routes.newAddress: (context) => NewDeliveryScreen(),
      Routes.profileOrder: (context) => ProfileOrderScreen(),
      Routes.profileOrderDetail: (context) => OrderDetail(),
      // Routes.profileTrackingOrder: (context) => TrackingOrderScreen(),
      // Routes.profileReceipt: (context) => ProfileReceipt(),
      Routes.profileWishlist: (context) => WishlistScreen(),

      // Go to my order after clicking check out
      Routes.myOrder: (context) => MyOrderScreen(),
      Routes.orderSuccess: (context) => OrderSuccessScreen(),

      // home
      Routes.home: (context) => TrackingOrderScreen(),

      // product
      Routes.productDetail: (context) => ProductDetailScreen(),
      Routes.productDetailConfig: (context) => ProductDetailConfigScreen(),
      Routes.cart: (context) => CartScreen(),

      // option
      Routes.option: (context) => OptionScreen(),

      // category
      Routes.thirdLevelCategory: (context) => ThirdLevelCategoryScreen(),

      // Scan QR Screen
      Routes.qrScan: (context) => ScanPage(),

      // Camera
      Routes.qrResult: (context) => PostView(),
      Routes.register: (context) => Register()
    };
  }
}
