import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/data/models/ordered_history_detail.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/screens/image/detail_image_screen.dart';
import 'package:htb_mobile/views/widgets/ButtonField.dart';
import 'package:htb_mobile/views/widgets/order/card_order_detail.dart';
import 'package:htb_mobile/views/widgets/show_dialog.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  final orderId;

  OrderDetail({this.orderId});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  File _image;
  PickedFile image;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: SubScreenAppBar.getAppBar('Order Details'),
        backgroundColor: Colors.white,
        body: BlocBuilder<OrderedHistoryDetailCubit, OrderedHistoryDetail>(
          builder: (context, orders) {
            print(orders);
            if (orders == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (orders.code != 200) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${orders?.code}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: HexColor.fromHex('#f00000'), fontSize: 40),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('No Data Found !',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: HexColor.fromHex('#7F7C7B'))),
                      ]),
                ),
              );
            }
            return RefreshIndicator(
                child: ListView(
                  padding: EdgeInsets.all(AppSizes.sidePadding),
                  children: [
                    _buildCardProduct(orders.data.listItems),
                    _buildTotalPrice(orders.data.listItems),
                    _buildReceipt(orders.data.receiptUploads,
                        int.parse(widget.orderId).toString(), context)
                  ],
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 1000));
                  Provider.of<OrderedHistoryDetailCubit>(context, listen: false)
                      .getOrderedHistoryDetail(int.parse(widget.orderId));
                });
          },
        ));
  }

  Widget _buildCardProduct(List<ListItems> orders) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CardOrderHistoryDetail(
            item: orders[index],
            watingOrder: null,
          );
        });
  }

  Widget _buildTotalPrice(List<ListItems> orders) {
    double totalPrice = 0;
    for (int i = 0; i < orders.length; i++) {
      totalPrice += double.parse(orders[i].amount.replaceAll(',', ''));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Total',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGray),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '\$ ${double.parse(totalPrice.toStringAsFixed(2))}',
            style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget _buildReceipt(
      List<ReceiptUploads> receipts, String orderID, BuildContext context) {
    print('receipt $receipts');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Invoice',
            style: TextStyle(
                color: AppColors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          height: 150,
          child: receipts.isEmpty
              ? Image.asset('assets/images/no_receipt.png')
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: receipts.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          child: FadeInImage(
                            image: receipts != null
                                ? NetworkImage(receipts[index].image)
                                : AssetImage('assets/images/no_receipt.png'),
                            placeholder:
                                AssetImage('assets/images/no_receipt.png'),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return DetailImageScreen(
                                  imageUrl: receipts[index].image);
                            }));
                          },
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(
                                MdiIcons.deleteCircle,
                                color: Colors.black,
                              ),
                              onTap: () {
                                _deleteReceipt(receipts[index].receiptId,
                                    orderID, context);
                              },
                            )),
                      ],
                    );
                  }),
        ),
        SizedBox(height: 10),
        Container(
          child: Text(
            'Your New Receipt',
            style: TextStyle(
                color: AppColors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          width: 250,
          height: 150,
          child: Stack(children: [
            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 250,
                    )
                  : Image.asset(
                      'assets/images/default_image.png',
                      width: 250,
                    ),
            ),
            Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: TextButton(
                  child: Text('+',
                      style: TextStyle(color: Colors.black, fontSize: 20.0)),
                  onPressed: () {
                    _getImageGallery(context);
                  },
                )),
          ]),
        ),
        ButtonField(
            title: 'Upload Receipt',
            onPressed: () {
              _uploadReceipt(widget.orderId.toString());
            }),
      ],
    );
  }

  _getImageGallery(BuildContext context) async {
    image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    print('image $image');
    if (image != null) {
      File imageFile = File(image.path);
      setState(() {
        _image = imageFile;
      });
    }
  }

  _uploadReceipt(String orderId) {
    if (image != null) {
      BlocProvider.of<OrderedHistoryDetailCubit>(context)
          .uploadReceipt(image.path, orderId);
      setState(() {
        _image = null;
      });
    } else {
      ShowDialog().showcontent(
          context, 'HTB Receipt', 'Please select your receipt to upload !!');
    }
  }

  _deleteReceipt(String receiptId, String orderId, BuildContext context) {
    BlocProvider.of<OrderedHistoryDetailCubit>(context)
        .removeReceipt(receiptId, orderId);
  }
}
