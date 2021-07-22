import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/ordered_history_cubit.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/data/models/history_order.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/order/button_order.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:provider/provider.dart';

import 'awaiting_detail_screen.dart';

class AwaitingApprovalScreen extends StatefulWidget {
  @override
  _AwaitingApprovalScreenState createState() => _AwaitingApprovalScreenState();
}

class _AwaitingApprovalScreenState extends State<AwaitingApprovalScreen> {
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
        appBar: SubScreenAppBar.getAppBar('Awaiting Approval'),
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
                        .getAwaitingApproval(page);
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
                                  .getAwaitingApproval(page);
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
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: <Widget>[
            // Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                order?.date,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              SizedBox(
                height: AppSizes.sidePadding,
              ),
              Text(
                '\$ ${order?.totalAmount}',
                style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              SizedBox(
                height: AppSizes.sidePadding,
              ),
              Text(
                'reference ${order?.reference}',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                height: AppSizes.linePadding,
              ),

              _buildButtonBottomCard(context, order)
              // ],
              // )
            ],
          ),
        ));
  }

  Widget _buildButtonBottomCard(BuildContext context, ListOrders order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonOrder(
          text: order?.status,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          paddingHorizontal: 10,
          paddingVertical: 5,
          borderRadius: 0,
          onPressed: () {
            print('${order?.status}');
          },
        ),
        Row(children: [
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
                    builder: (context) => BlocProvider<AwaitingApprovalCubit>(
                      create: (context) => AwaitingApprovalCubit()
                        ..getAwaitingApprovalDetail(int.parse(order?.orderId)),
                      child: AwaitingDetailScreen(
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
}
