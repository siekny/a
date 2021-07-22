import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailImageScreen extends StatelessWidget {
  final imageUrl;
  DetailImageScreen({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.6,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Center(
            child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        )),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
