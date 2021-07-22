import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/ordered_history_detail_cubit.dart';
import 'package:htb_mobile/services/receipt_service.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/order/button_order.dart';
import 'package:htb_mobile/views/widgets/show_dialog.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String orderId;
  PaymentScreen({@required this.orderId});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File _image;
  PickedFile image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar.getAppBar('Payment'),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Text(
              'upload your payment reciept so that admin would know you’re not a spam',
              style:
                  TextStyle(color: HexColor.fromHex('#231F20'), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 30,
          ),

          // drop payment
          DottedBorder(
            color: HexColor.fromHex('#E59F1A'), //color of dotted/dash line
            strokeWidth: 1, //thickness of dash/dots
            dashPattern: [5, 5],
            //dash patterns, 10 is dash width, 6 is space width
            child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: InkWell(
                    child: Column(
                      children: [
                        Icon(MdiIcons.cloudDownload,
                            color: HexColor.fromHex('#A8A8A8')),
                        SizedBox(height: 8),
                        Text(
                          'Drag and drop here',
                          style: TextStyle(
                              color: HexColor.fromHex('#969696'), fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        // InkWell(
                        Text('Browse',
                            style: TextStyle(
                                color: HexColor.fromHex('#0085FF'),
                                fontSize: 12)),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: _image != null
                              ? Image.file(
                                  _image,
                                  width: 150,
                                  // height: 100,
                                  // fit: BoxFit.fitHeight,
                                )
                              : Text(''),
                        )
                        // onTap: null)
                      ],
                    ),
                    onTap: () {
                      _uploadPayment(context);
                    })),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonOrder(
            text: 'Payment',
            textColor: Colors.white,
            backgroundColor: Colors.orange,
            paddingHorizontal: 15,
            paddingVertical: 13,
            borderRadius: 3,
            onPressed: () {
              _uploadReceipt(widget.orderId);
            },
          ),
        ]),
      ),
    );
  }

  void _uploadPayment(BuildContext context) {
    _getImageGallery(context);
  }

  void _uploadReceipt(String orderId) {
    if (image != null) {
      BlocProvider.of<OrderedHistoryDetailCubit>(context)
          .uploadReceipt(image.path, orderId);
      setState(() {
        _image = null;
      });
      Navigator.of(context).pop();
    } else {
      ShowDialog().showcontent(
          context, 'HTB Receipt', 'Please select your receipt to upload !!');
    }
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
      ReceiptService().addReceiptsInLocal(image.path);
    }
  }
}
