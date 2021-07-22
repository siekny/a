import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/receipt_cubit.dart';
import 'package:htb_mobile/data/models/receipt.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/views/screens/image/detail_image_screen.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  List<String> _receipts;
  ScrollController _scrollController = ScrollController(
    initialScrollOffset: 20, // or whatever offset you wish
    keepScrollOffset: true,
  );
  int page = 1;

  @override
  void initState() {
    super.initState();
    _receipts = [];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubScreenAppBar.getAppBar('Receipt'),
      body: Constant.getToken() == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => Login()))
          : BlocBuilder<ReceiptCubit, Receipt>(builder: (context, data) {
              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (data.receiptUploads.isEmpty) {
                return Center(
                  child: Text('No Receipt Yet'),
                );
              }
              _receipts.addAll(data.receiptUploads);
              return RefreshIndicator(
                  child: Container(
                      child: GridView.count(
                    crossAxisCount: 3,
                    controller: _scrollController
                      ..addListener(() {
                        if (_scrollController.position.pixels ==
                            _scrollController.position.maxScrollExtent) {
                          // ... call method to load more repositories
                          print('more receipt');

                          if (++page <= int.parse(data.lastPage)) {
                            print('page view $page');
                            Provider.of<ReceiptCubit>(context, listen: false)
                                .getReceipt(page);
                          }
                          //page = int.parse(data.page);
                        }
                      }),
                    children: List.generate(_receipts.length, (index) {
                      return Center(
                        child: _buildReceipt(_receipts[index], index),
                      );
                    }),
                  )),
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1000));
                    _receipts = [];
                    page = 1;
                    Provider.of<ReceiptCubit>(context, listen: false)
                        .getReceipt(page);
                  });
            }),
    );
  }

  Widget _buildReceipt(String img, int index) {
    return Container(
        padding: EdgeInsets.all(5),
        child: GestureDetector(
          child: Hero(
            tag: index,
            child: FadeInImage(
              image: NetworkImage(img),
              placeholder: AssetImage('assets/images/no_receipt.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailImageScreen(imageUrl: img);
            }));
          },
        ));
  }
}
