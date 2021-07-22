import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/cubit/tracking_cubit.dart';
import 'package:htb_mobile/data/models/tracking.dart';
import 'package:htb_mobile/data/models/tracking_status.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/utils/color_constants.dart';
import 'package:htb_mobile/utils/font_constants.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TrackingOrderScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _widthFull = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    var _width = _widthFull - 30;

    return Scaffold(
        appBar: SubScreenAppBar.getAppBar('Tracking Order'),
        backgroundColor: Colors.white,
        body: Constant.getToken() == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => Login()))
            : BlocBuilder<TrackingCubit, Tracking>(
                builder: (context, tracking) {
                if (tracking == null) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('There are Some Issue with Tracking',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: HexColor.fromHex('#7F7C7B'))),
                    ),
                  );
                }
                if (tracking?.code != 200) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${tracking?.code}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor.fromHex('#f00000'),
                                  fontSize: 40),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('There are Some Issue with Tracking',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor.fromHex('#7F7C7B'))),
                          ]),
                    ),
                  );
                }
                return ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    searchCode(context),
                    SizedBox(height: 30),
                    Text('Your lasted product ordered : '),
                    SizedBox(
                      height: 30,
                    ),
                    cardProduct(
                        _width,
                        tracking?.data?.itemId,
                        tracking?.data?.productName,
                        tracking?.data?.productCode,
                        tracking?.data?.colorSize,
                        tracking?.data?.thumbnail,
                        context),
                    SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // shop name (first start)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 2),
                                              decoration: BoxDecoration(
                                                  color: tracking
                                                          ?.data
                                                          ?.trackingStatus[0]
                                                          .isSelected
                                                      ? AppColors.orange
                                                      : HexColor.fromHex(
                                                          '#F3F3F3'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                MdiIcons.checkUnderline,
                                                color: tracking
                                                        ?.data
                                                        ?.trackingStatus[0]
                                                        .isSelected
                                                    ? AppColors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),

                                        width: _width / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          color: HexColor.fromHex('#F3F3F3'),
                                        ),
                                        // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: _width / 3,
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Ordered',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // pick up product
                                  Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 2),
                                              decoration: BoxDecoration(
                                                  color: tracking
                                                          ?.data
                                                          ?.trackingStatus[3]
                                                          .isSelected
                                                      ? AppColors.orange
                                                      : HexColor.fromHex(
                                                          '#F3F3F3'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                MdiIcons.moped,
                                                color: tracking
                                                        ?.data
                                                        ?.trackingStatus[3]
                                                        .isSelected
                                                    ? AppColors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),

                                        width: _width / 3,
                                        decoration: BoxDecoration(
                                          color: HexColor.fromHex('#F3F3F3'),
                                        ),
                                        // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        color: Colors.white,
                                        width: _width / 3,
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('Delivering',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                    ],
                                  ),

                                  // to customer
                                  Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 2, 10, 2),
                                              decoration: BoxDecoration(
                                                  color: tracking
                                                          ?.data
                                                          // ignore: null_aware_before_operator
                                                          ?.trackingStatus[tracking
                                                                  ?.data
                                                                  ?.trackingStatus
                                                                  ?.length -
                                                              1]
                                                          .isSelected
                                                      ? AppColors.orange
                                                      : HexColor.fromHex(
                                                          '#F3F3F3'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                MdiIcons.handHeartOutline,
                                                color: tracking
                                                        ?.data
                                                        ?.trackingStatus[tracking
                                                                .data
                                                                .trackingStatus
                                                                .length -
                                                            1]
                                                        .isSelected
                                                    ? AppColors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),

                                        width: _width / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                          ),
                                          color: HexColor.fromHex('#F3F3F3'),
                                        ),
                                        // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        color: Colors.white,
                                        width: _width / 3,
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text('Delivered ',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                    trackingWidget(tracking?.data?.trackingStatus)
                  ],
                );
              }));
  }

  Widget searchCode(BuildContext context) {
    return TextField(
      controller: _codeController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        hintText: 'Enter your product code',
        hintStyle: TextStyle(fontSize: 14, color: HexColor.fromHex('#BABABA')),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex('#BCBEC0')),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        suffixIcon: InkWell(
          child: const Icon(
            Icons.search,
            color: Colors.orange,
          ),
          onTap: () {
            _searchTrackingByCode(_codeController.text, context);
            print('code ${_codeController.text}');
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  Widget cardProduct(
      double width,
      String productId,
      String productName,
      String productCode,
      String colorSize,
      String thumbnail,
      BuildContext context) {
    return InkWell(
        onTap: () {
          print('object');
        },
        child: Container(
            padding: EdgeInsets.all(AppSizes.linePadding * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.lightGray.withOpacity(0.3),
                      blurRadius: AppSizes.imageRadius,
                      offset: Offset(0.0, AppSizes.imageRadius))
                ],
                color: AppColors.white),
            child: Stack(children: <Widget>[
              Row(
                children: <Widget>[
                  // product's image
                  Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: HexColor.fromHex('#f5f5f5'))),
                      child: FadeInImage(
                        image: NetworkImage(thumbnail),
                        placeholder: AssetImage('assets/images/no_product.png'),
                        fit: BoxFit.cover,
                      )),

                  // product's content
                  Container(
                      padding: EdgeInsets.only(left: AppSizes.sidePadding),
                      // width: width - 130,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: width - 150,
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('$productName',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      FontConstants.fontContent,
                                                  color: HexColor.fromHex(
                                                      '#231F20'),
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(height: 8),
                                          Text(
                                            'Code : $productCode',
                                            style: TextStyle(
                                                color: HexColor.fromHex(
                                                    '#7F7C7B')),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${colorSize.replaceAll('[{', "").replaceAll('}]', "")}',
                                            style: TextStyle(
                                                fontSize:
                                                    FontConstants.fontContent),
                                          ),
                                        ],
                                      )),
                                ]),
                          ]))
                ],
              ),
            ])));
  }

  Widget trackingWidget(List<TrackingStatus> trackingStatuses) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: trackingStatuses.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: trackingStatuses[index].isSelected
                          ? ColorConstants.primaryHex
                          : HexColor.fromHex('#C4C4C4'),
                      child: ImageIcon(
                        NetworkImage(
                          trackingStatuses[index].icon,
                        ),
                        color: Colors.white,
                        size: 30,
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            '${trackingStatuses[index].title}',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Text(
                          '${trackingStatuses[index].date}',
                          style: TextStyle(
                              fontSize: 11, color: HexColor.fromHex('#7F7C7B')),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              trackingStatuses.length - 1 > index
                  ? Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(11, 0, 0, 0),
                      child: Row(
                        children: [
                          VerticalDivider(
                            color: HexColor.fromHex('#C4C4C4'),
                            thickness: 2,
                            indent: 0,
                            endIndent: 0,
                          )
                        ],
                      ))
                  : Text(''),
            ],
          );
        });
  }

  void _searchTrackingByCode(code, context) {
    Provider.of<TrackingCubit>(context, listen: false)
        .getTrackingByItemCode(code);
  }
}
