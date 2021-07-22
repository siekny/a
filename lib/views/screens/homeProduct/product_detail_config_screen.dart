import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/views/widgets/productDetailConfigurator/choiceChip.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class ProductDetailConfigScreen extends StatefulWidget {
  @override
  _ProductDetailConfigScreenState createState() =>
      _ProductDetailConfigScreenState();
}

class _ProductDetailConfigScreenState extends State<ProductDetailConfigScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  double sizeBetween;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    sizeBetween = height / 20;

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, List<dynamic>>;
    final properties = routeArgs["property"] as List<dynamic>;

    Constant.selectedConfig.clear();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar.getAppBar('Options'),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: properties.map((e) {
                        final values = e["Value"] as List<dynamic>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${e["DisplayName"]}"),
                            // final value = widget.value[i] as List<dynamic>;
                            choiceChipWidget(
                              value: values,
                              parentProperty: e["DisplayName"],
                            )
                          ],
                        );
                      }).toList()),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Quantity"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomNumberPicker(
                    initialValue: 1,
                    maxValue: 100,
                    minValue: 1,
                    step: 1,
                    onValue: (value) {
                      if (value <= 0) {}
                      Constant.qty = int.parse(value.toString());
                    },
                  )
                ],
              ))),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  // print(Constant.selectedConfig);
                  Navigator.of(context).pop();

                  // Navigator.of(context, rootNavigator: true)
                  //     .pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xffFDBA2D),
                  child: Text("Continue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
