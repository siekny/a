import 'package:flutter/material.dart';
import 'package:htb_mobile/views/widgets/skeleton/skeleton_container.dart';

class SearchSkeleton extends StatelessWidget {
  const SearchSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: SkeletonContainer.rounded(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SkeletonContainer.rounded(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 25,
              ),
              const SizedBox(height: 8),
              SkeletonContainer.rounded(
                width: 60,
                height: 13,
              ),
            ],
          ),
        ],
      );
}
