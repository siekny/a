import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class TitleSkeleton extends StatelessWidget {
  const TitleSkeleton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SkeletonAnimation(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width / 1.5,
          margin: EdgeInsets.only(top: 30, bottom: 0, left: 15),
          child: Row(children: [
            Expanded(
              child: SkeletonAnimation(
                shimmerColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                shimmerDuration: 1000,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                ),
              ),
            ),
          ])));
}
