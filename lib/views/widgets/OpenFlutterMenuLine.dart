import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

class OpenFlutterMenuLine extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OpenFlutterMenuLine(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.amber,
          size: 24,
        ),
        title: Align(
          child: Text(
            title,
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          alignment: Alignment.topLeft,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.amber,
        ),
      ),
      onTap: onTap,
    );
  }
}
