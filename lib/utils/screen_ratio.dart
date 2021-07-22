import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ScreenRatio {
  static double heightRatio;
  static double widthRatio;
  static double screenHeight;
  static double screenWidth;

  static setScreenRatio(
      {double currentScreenHeight, double currentScreenWidth}) {
    screenHeight = currentScreenHeight;
    screenWidth = currentScreenWidth;
    heightRatio = currentScreenHeight / 667.0;
    widthRatio = currentScreenWidth / 375.0;
  }

  ScreenRatio init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    setPortrait();
    return this;
  }

  bool get isIos => Platform.isIOS;

  bool get isAndroid => Platform.isAndroid;

  void setPortrait() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  void closeKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
