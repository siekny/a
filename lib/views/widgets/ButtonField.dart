import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/font_constants.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

class ButtonField extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final String title;
  final IconData icon;
  final double iconSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;

  ButtonField({
    Key key,
    this.width,
    this.height,
    @required this.title,
    @required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.orange,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.orange,
    this.iconSize = 18.0,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (width == null || height == null) {
      // edgeInsets = EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0);
    }
    return Container(
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: 45,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide.none),
          backgroundColor:
              MaterialStateProperty.all(HexColor.fromHex('#E59F1A')),
          foregroundColor:
              MaterialStateProperty.all(HexColor.fromHex('#ffffff')),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: FontConstants.fontContent,
            ),
          ),
          // side: MaterialStateProperty.all(HexColor.fromHex('hexString'))
          // side: BorderSide(color: Colors.red, width: 5, ),
        ),
      ),
    );
  }
}
