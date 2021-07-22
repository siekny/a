import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  List<dynamic> configList;
  CustomRadio(this.configList);
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  @override
  void initState() {
    super.initState();
    print(widget.configList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("ddd"),
        Container(
          margin: EdgeInsets.only(top: 10, left: 10, bottom: 30),
          child: Wrap(
            children: widget.configList.map((data) {
              var index = widget.configList.indexOf(data);
              return InkWell(
                  onTap: () {
                    setState(() {
                      print(widget.configList);
                      widget.configList
                          .forEach((element) => element.isSelected = false);
                      widget.configList[index].isSelected = true;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
                      child: new RadioItem(false, "value", "text")));
            }).toList(),
          ),
        )
      ],
    );
  }
}

class RadioItem extends StatelessWidget {
  final bool isSelected;
  final String value;
  final String text;
  RadioItem(this.isSelected, this.value, this.text);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: FlatButton(
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Text("$text ",
            style: new TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                //fontWeight: FontWeight.bold,
                fontSize: 14.0)),
      ),
      decoration: new BoxDecoration(
        color: isSelected ? Colors.amber : Colors.transparent,
        border: new Border.all(
            width: 1.0, color: isSelected ? Colors.amber : Colors.grey),
        borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
      ),
    );
  }
}
// class RadioModel {
//   bool isSelected;
//   final String value;
//   final String text;
//
//   RadioModel(this.isSelected, this.value, this.text);
// }