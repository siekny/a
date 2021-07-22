import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/ordered_history_cubit.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/cubit/receipt_cubit.dart';
import 'package:htb_mobile/cubit/tracking_cubit.dart';
import 'package:htb_mobile/data/models/history_order.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/services/ordered_history_one_detail_service.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/profile/order_detail.dart';
import 'package:htb_mobile/views/screens/profile/payment_screen.dart';
import 'package:htb_mobile/views/screens/profile/tracking_order_screen.dart';
import 'package:htb_mobile/views/widgets/order/button_order.dart';
import 'package:htb_mobile/views/widgets/show_dialog.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:provider/provider.dart';

class ProfileOrderScreen extends StatefulWidget {
  @override
  _ProfileOrderScreenState createState() => _ProfileOrderScreenState();
}

class _ProfileOrderScreenState extends State<ProfileOrderScreen> {
  List<ListOrders> _orders;
  ScrollController _scrollController = ScrollController(
    initialScrollOffset: 20, // or whatever offset you wish
    keepScrollOffset: true,
  );
  int page = 1;

  @override
  void initState() {
    super.initState();
    _orders = [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubScreenAppBar.getAppBar('Order'),
        backgroundColor: Colors.white,
        body: Constant.getToken() == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => Login()))
            : BlocBuilder<OrderedHistoryCubit, OrderedHistory>(
                builder: (context, data) {
                if (data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (data.listOrders.isEmpty) {
                  return Center(
                    child: Text('No Order Yet.'),
                  );
                }

                _orders.addAll(data.listOrders);
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1000));
                    _orders = [];
                    page = 1;
                    Provider.of<OrderedHistoryCubit>(context, listen: false)
                        .getOrderedHistory(page);
                  },
                  child: ListView.builder(
                      controller: _scrollController
                        ..addListener(() {
                          if (_scrollController.position.pixels ==
                              _scrollController.position.maxScrollExtent) {
                            // ... call method to load more repositories
                            print('more receipt');

                            if (++page <= int.parse(data.lastPage)) {
                              print('page view $page');
                              Provider.of<OrderedHistoryCubit>(context,
                                      listen: false)
                                  .getOrderedHistory(page);
                            }
                            //page = int.parse(data.page);
                          }
                        }),
                      itemCount: _orders.length,
                      itemBuilder: (context, index) {
                        return _buildCard(context, _orders[index]);
                      }),
                );
              }));
  }

  Card _buildCard(BuildContext context, ListOrders order) {
    return Card(
        elevation: 4,
        shadowColor: Colors.black26,
        child: Container(
          padding: EdgeInsets.all(AppSizes.sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order?.date,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  order.paymentStatus == 'pending' ||
                          order.paymentStatus == 'be ordered' ||
                          order.paymentStatus == 'be order'
                      ? InkWell(
                          child: Text(
                            'Payment',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<OrderedHistoryDetailCubit>(
                                    create: (context) =>
                                        OrderedHistoryDetailCubit()
                                          ..getOrderedHistoryDetail(
                                              int.parse(order?.orderId)),
                                    child: PaymentScreen(
                                      orderId: order?.orderId,
                                    ),
                                  ),
                                ));
                          },
                        )
                      : Text('')
                ],
              ),
              SizedBox(
                height: AppSizes.sidePadding,
              ),
              Text(
                '\$ ${order?.totalCost}',
                style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              SizedBox(
                height: AppSizes.sidePadding,
              ),
              Text(
                '¥ ${(double.parse(order.totalCost.replaceAll(',', '')) * double.parse(order.exchangeY.replaceAll(',', ''))).toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                height: AppSizes.linePadding,
              ),
              _buildButtonBottomCard(context, order)
            ],
          ),
        ));
  }

  Widget _buildButtonBottomCard(BuildContext context, ListOrders order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonOrder(
          text: order?.paymentStatus,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          paddingHorizontal: 10,
          paddingVertical: 5,
          borderRadius: 0,
          onPressed: () {},
        ),
        Row(children: [
          ButtonOrder(
            text: 'Tracking',
            textColor: Colors.white,
            backgroundColor: AppColors.orange,
            paddingHorizontal: 10,
            paddingVertical: 5,
            borderRadius: AppSizes.textFieldRadius,
            onPressed: () {
              OrderedHistoryDetailService service =
                  OrderedHistoryDetailService();
              service.getOrderedHistoryDetail(int.parse(order?.orderId)).then(
                  (value) => value?.data != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<TrackingCubit>(
                              create: (context) => TrackingCubit()
                                ..getTrackingByItemCode(
                                    value?.data?.listItems[0]?.productCode),
                              child: TrackingOrderScreen(),
                            ),
                          ))
                      : ShowDialog().showcontent(
                          context, '${value?.code}', 'There is no Data !!!'));
            },
          ),
          SizedBox(
            width: 10,
          ),
          ButtonOrder(
            text: 'Details',
            textColor: Colors.white,
            backgroundColor: Colors.green,
            paddingHorizontal: 10,
            paddingVertical: 5,
            borderRadius: AppSizes.textFieldRadius,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider<OrderedHistoryDetailCubit>(
                      create: (context) => OrderedHistoryDetailCubit()
                        ..getOrderedHistoryDetail(int.parse(order?.orderId)),
                      child: OrderDetail(
                        orderId: order?.orderId,
                      ),
                    ),
                  ));
            },
          ),
        ])
      ],
    );
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            'Empty',
            style: TextStyle(color: Colors.red),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('There is no Data !!!'),
              ],
            ),
          ),
          actions: [
            new TextButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
