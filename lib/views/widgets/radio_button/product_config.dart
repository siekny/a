import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
class ProductConfig extends StatefulWidget {
  String title;
  List values;
  ProductConfig(this.title,this.values);

  @override
  _ProductConfigState createState() => _ProductConfigState();
}

class _ProductConfigState extends State<ProductConfig> {

  String verticalGroupValue;
  List<String> status = ["Pending", "Released", "Soth"];
  List<String> status2 = ["test2", "test34"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Text("${widget.title}",style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),),
        RadioGroup<String>.builder(
          groupValue: verticalGroupValue,
          onChanged: (value) => setState(() {
            verticalGroupValue = value;
          }),
          items: status,
          itemBuilder: (item) => RadioButtonBuilder(item),
        )
      ],
    );
  }
}
