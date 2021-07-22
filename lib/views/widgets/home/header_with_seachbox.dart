import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/bannerCubit.dart';
import 'package:htb_mobile/views/widgets/home/slide_banner_home.dart';
import 'package:htb_mobile/views/widgets/search_bar.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      padding: EdgeInsets.all(0),
      // It will cover 20% of our total height
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          BlocProvider<BannerCubit>(
            create: (context) => BannerCubit()..getBanners(),
            child: SlideBanner(),
          ),
          // SearchBar(),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
          //     child: SearchBar(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
