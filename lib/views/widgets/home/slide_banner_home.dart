import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/bannerCubit.dart';
import 'package:htb_mobile/data/models/banner.dart';
import 'package:htb_mobile/views/widgets/skeleton/banner_skeleton.dart';

class SlideBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SlideBannerState();
  }
}

List<Widget> imageSliders;

class SlideBannerState extends State<SlideBanner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerOT>(
      builder: (context, banner) {
        if (banner.result == null) {
          return BannerSkeleton();
        }

        bannerToList(banner.result.content);

        return Column(children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: imgList.map((url) {
          //     int index = imgList.indexOf(url);
          //     return Container(
          //       width: 8.0,
          //       height: 8.0,
          //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: _current == index
          //             ? Color.fromRGBO(0, 0, 0, 0.9)
          //             : Color.fromRGBO(0, 0, 0, 0.4),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ]);
      },
    );
  }
}

void bannerToList(List<Content> content) {
  final List<String> imgList = <String>[];

  for (var i = 0; i < content.length; i++) {
    imgList.add(content[i].pictureUrl);
  }
  print(imgList);

  imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Text('Check your internet connection');
                        },
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       Color.fromARGB(200, 0, 0, 0),
                          //       Color.fromARGB(0, 0, 0, 0)
                          //     ],
                          //     begin: Alignment.bottomCenter,
                          //     end: Alignment.topCenter,
                          //   ),
                          // ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
