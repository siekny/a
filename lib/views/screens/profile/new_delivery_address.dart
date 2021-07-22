import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/user_cubit.dart';
import 'package:htb_mobile/data/models/address.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/ButtonField.dart';
import 'package:htb_mobile/views/widgets/InputField.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class NewDeliveryScreen extends StatefulWidget {
  @override
  _NewDeliveryScreenState createState() => _NewDeliveryScreenState();
}

class _NewDeliveryScreenState extends State<NewDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubScreenAppBar.getAppBar('New Delivery Address'),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(AppSizes.sidePadding),
            child: BlocProvider(
              create: (_) => UserCubit(),
              child: ButtonSaveView(),
            )));
  }
}

class ButtonSaveView extends StatefulWidget {
  @override
  _ButtonSaveViewState createState() => _ButtonSaveViewState();
}

class _ButtonSaveViewState extends State<ButtonSaveView> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Address objAddress =
        ModalRoute.of(context).settings.arguments as Address;
    addressController.text = objAddress.address;
    contactNumberController.text = objAddress.phone;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(
            controller: addressController,
            hint: 'Address',
          ),
          InputField(
            controller: contactNumberController,
            hint: 'Contact Number',
          ),
          SizedBox(
            height: 15,
          ),
          ButtonField(title: 'Save Change', onPressed: _validateAndUpdate),
        ],
      ),
    );
  }

  void _validateAndUpdate() {
    var jsonUser;
    if (addressController.text.isEmpty ||
        contactNumberController.text.isEmpty) {
      print('null value');
    } else {
      jsonUser = jsonEncode(<String, String>{
        'phone': '${contactNumberController.text}',
        'address': '${addressController.text}',
      });

      BlocProvider.of<UserCubit>(context).updateUser(jsonUser);
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }
  }
}
