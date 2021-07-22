import 'package:flutter/material.dart';

class ButtonOrder extends StatelessWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final FontWeight fontWeight;
  final String text;
  final Function onPressed;

  ButtonOrder(
      {this.text,
      this.textColor,
      this.fontWeight,
      this.backgroundColor,
      this.paddingVertical,
      this.paddingHorizontal,
      this.borderRadius,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.fromLTRB(paddingHorizontal, paddingVertical,
                  paddingHorizontal, paddingVertical),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: fontWeight),
                textAlign: TextAlign.center,
              ),
              // ),
            ));
  }
}
