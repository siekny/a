import 'package:flutter/material.dart';
import 'package:htb_mobile/views/widgets/skeleton/skeleton_container.dart';
import 'package:htb_mobile/views/widgets/skeleton/title_skeleton.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: [TitleSkeleton()],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: SkeletonContainer.rounded(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: SkeletonContainer.rounded(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: SkeletonContainer.rounded(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
