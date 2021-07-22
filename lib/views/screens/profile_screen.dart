import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/cubit/receipt_cubit.dart';
import 'package:htb_mobile/cubit/tracking_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/cubit/ordered_history_cubit.dart';
import 'package:htb_mobile/cubit/user_cubit.dart';
import 'package:htb_mobile/services/history_order_service.dart';
import 'package:htb_mobile/services/ordered_history_one_detail_service.dart';
import 'package:htb_mobile/utils/color_constants.dart';
import 'package:htb_mobile/views/screens/profile/awaiting_approval_screen.dart';
import 'package:htb_mobile/views/screens/profile/edit_profile_screen.dart';
import 'package:htb_mobile/views/screens/profile/profile_order_screen.dart';
import 'package:htb_mobile/views/screens/profile/receipt_screen.dart';
import 'package:htb_mobile/views/screens/profile/tracking_order_screen.dart';
import 'package:htb_mobile/views/screens/profile/wishlist_screen.dart';
import 'package:htb_mobile/views/widgets/OpenFlutterMenuLine.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  OrderedHistoryService orders = OrderedHistoryService();
  OrderedHistoryDetailService detail = OrderedHistoryDetailService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: ColorConstants.primaryHex),
        ),
        backgroundColor: Colors.white24,
      ),
      body:
          // Text('hello')

          ListView(children: [
        Column(children: [
          SizedBox(
            height: 15.0,
          ),
          OpenFlutterMenuLine(
              title: 'Profile',
              icon: Icons.person_outline,
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<UserCubit>(
                            create: (context) => UserCubit()..getUser(),
                            child: EditProfileScreen(),
                          ),
                        )),
                  })),
          OpenFlutterMenuLine(
              title: 'Order',
              icon: MdiIcons.mapOutline,
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<OrderedHistoryCubit>(
                                create: (context) =>
                                    // page = 1
                                    OrderedHistoryCubit()..getOrderedHistory(1),
                              ),
                              BlocProvider<OrderedHistoryDetailCubit>(
                                create: (context) =>
                                    OrderedHistoryDetailCubit(),
                              ),
                            ],
                            child: ProfileOrderScreen(),
                          ),
                        )),
                  })),
          OpenFlutterMenuLine(
              title: 'Wistlists',
              icon: MdiIcons.heartOutline,
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<WishListCubit>(
                                create: (context) =>
                                    WishListCubit()..getWishLists(),
                              ),
                              BlocProvider<ProductDetailCubit>(
                                create: (context) => ProductDetailCubit(),
                              ),
                            ],
                            child: WishlistScreen(),
                          ),
                        )),
                  })),
          OpenFlutterMenuLine(
              title: 'Tracking Order',
              icon: MdiIcons.longitude,
              onTap: (() => {
                    // page = 1
                    orders.getOrderedHistories(1).then((value) => value
                            .listOrders.isEmpty
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<TrackingCubit>(
                                create: (context) =>
                                    TrackingCubit()..getTrackingByItemCode('0'),
                                child: TrackingOrderScreen(),
                              ),
                            ))
                        : detail
                            .getOrderedHistoryDetail(
                                int.parse(value?.listOrders[0].orderId))
                            .then(
                              (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<TrackingCubit>(
                                      create: (context) => TrackingCubit()
                                        ..getTrackingByItemCode(value
                                            ?.data?.listItems[0].productCode),
                                      child: TrackingOrderScreen(),
                                    ),
                                  )),
                            ))
                  })),
          OpenFlutterMenuLine(
              title: 'Awaiting Approval',
              icon: MdiIcons.mapOutline,
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<OrderedHistoryCubit>(
                                create: (context) =>
                                    // page = 1
                                    OrderedHistoryCubit()
                                      ..getAwaitingApproval(1),
                              ),
                              BlocProvider<OrderedHistoryDetailCubit>(
                                create: (context) =>
                                    OrderedHistoryDetailCubit(),
                              ),
                            ],
                            child: AwaitingApprovalScreen(),
                          ),
                        )),
                  })),
          OpenFlutterMenuLine(
              title: 'Receipt',
              icon: MdiIcons.noteTextOutline,
              onTap: (() => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<ReceiptCubit>(
                            create: (context) => ReceiptCubit()..getReceipt(1),
                            child: ReceiptScreen(),
                          ),
                        )),
                  })),
          OpenFlutterMenuLine(
              title: 'Logout',
              icon: MdiIcons.logout,
              onTap: (() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => Login()));
              })),
        ])
      ]),
    );
  }
}
