import 'package:flutter/material.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:toast/toast.dart';

class choiceChipWidget extends StatefulWidget {
  final List<dynamic> value;
  final String parentProperty;
  choiceChipWidget({Key key, this.value, this.parentProperty});

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var i = 0; i < widget.value.length; i++) {
      // print(widget.value[i]["DisplayName"]);
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(widget.value[i]["DisplayName"]),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == widget.value[i]["DisplayName"],
          avatar: widget.value[i]["Picture"] == null
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : Container(
                  width: 220.0,
                  height: 220.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              widget.value[i]["Picture"]["Url"])))),
          onSelected: (selected) {
            // print(
            // widget.parentProperty + "//" + widget.value[i]["DisplayName"]);
            addPropertiesToMap(Constant.selectedConfig, widget.parentProperty,
                widget.value[i]["DisplayName"]);
            setState(() {
              selectedChoice = widget.value[i]["DisplayName"];
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  void addPropertiesToMap(
      List<Map<String, String>> selectedProperties, parent, subProperties) {
    if (selectedProperties.isEmpty) {
      selectedProperties.add({parent: subProperties});
    }
    selectedProperties.forEach((element) {
      if (element.containsKey(parent)) {
        element.update(parent, (value) => value = subProperties);
      } else {
        element.addAll({parent: subProperties});
      }
    });

    print(selectedProperties.toString());
  }
}
