import 'package:flutter/material.dart';

class ShowDialog {
  void showcontent(BuildContext context, String title, String content) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title, style: TextStyle(color: Colors.red)),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(content),
              ],
            ),
          ),
          actions: [
            new TextButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
