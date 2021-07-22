import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

import '../../../utils/color_constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          // Spacer(),
          // TextButton(
          //     style: ButtonStyle(
          //       padding: MaterialStateProperty.all(EdgeInsets.zero),
          //       backgroundColor: MaterialStateProperty.all(AppColors.orange),
          //       foregroundColor: MaterialStateProperty.all(Colors.red),
          //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20))),
          //     ),
          //     // shape: RoundedRectangleBorder(
          //     //   borderRadius: BorderRadius.circular(20),
          //     // ),
          //     // color: ColorConstants.primaryColor,
          //     onPressed: press,
          //     child: Icon(
          //       Icons.more_horiz,
          //       color: Colors.white,
          //     )),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20 / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
