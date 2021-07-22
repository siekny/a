import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/data/models/ordered_history_detail.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/order/card_order_detail.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:provider/provider.dart';

class AwaitingDetailScreen extends StatefulWidget {
  final orderId;

  AwaitingDetailScreen({this.orderId});
  @override
  _AwaitingDetailScreenState createState() => _AwaitingDetailScreenState();
}

class _AwaitingDetailScreenState extends State<AwaitingDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final int orderId = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
        key: _scaffoldKey,
        appBar: SubScreenAppBar.getAppBar('Order Details'),
        backgroundColor: Colors.white,
        body: BlocBuilder<AwaitingApprovalCubit, List<AwaitingApproval>>(
          builder: (context, orders) {
            if (orders == null || orders.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.all(AppSizes.sidePadding),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return _buildCardProduct(
                          orders[index].items, orders[index].supplyer);

                      // _buildCardProduct(
                      //     orders[index].items, orders[index]);
                      // _buildTotalPrice(orders.items),
                    }),
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  Provider.of<AwaitingApprovalCubit>(context, listen: false)
                      .getAwaitingApprovalDetail(int.parse(widget.orderId));
                });
          },
        ));
  }

  Widget _buildCardProduct(List<ListItems> orders, String supplyer) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CardOrderHistoryDetail(
            item: orders[index],
            watingOrder: supplyer,
          );
        });
  }
}
