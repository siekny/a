import 'package:flutter/material.dart';
import 'package:htb_mobile/data/models/global_items.dart';

import 'filter_chip.dart';

class BigFilterChip extends StatefulWidget {
  final ContentP contentP;
  BigFilterChip({@required this.contentP}) : super();

  @override
  _BigFilterChipState createState() => _BigFilterChipState();
}

class _BigFilterChipState extends State<BigFilterChip> {
  @override
  Widget build(BuildContext context) {
    List<Widget> chipLists = [];
    for (var i = 0; i < this.widget.contentP.values.length; i++) {
      chipLists
          .add(filterChipWidget(chipName: this.widget.contentP.values[i].name));
    }
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _titleContainer(this.widget.contentP.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child:
                      Wrap(spacing: 5.0, runSpacing: 3.0, children: chipLists)),
            ),
          ),
          Divider(
            color: Colors.blueGrey,
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget _titleContainer(String myTitle) {
    return Text(
      myTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }
}