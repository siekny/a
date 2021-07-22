import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

class SubScreenAppBar {
  static getAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: AppColors.orange, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      elevation: 0.3,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: AppColors.orange, //change your color here
      ),
    );
  }
}
