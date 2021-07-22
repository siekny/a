import 'package:flutter/material.dart';
import 'package:htb_mobile/config/constant.dart';

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.normal),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        _savedSeletecProperties(isSelected, widget.chipName);
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.orange[200],
    );
  }

  void _savedSeletecProperties(bool isSelected, String property) {
    if (isSelected) {
      // Add property to list of String
      Constant.selectedProperties.add(property);
    } else {
      // Remove property from list of String
      Constant.selectedProperties.remove(property);
    }
    print(Constant.selectedProperties);
  }
}
