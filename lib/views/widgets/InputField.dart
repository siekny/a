import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator validator;
  final TextInputType keyboard;
  final Function onValueChanged;
  final String error;

  const InputField(
      {Key key,
      @required this.controller,
      this.hint,
      this.validator,
      this.keyboard = TextInputType.text,
      this.onValueChanged,
      this.error})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String error;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    error = widget.error;

    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboard,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: HexColor.fromHex('#fff'),
            hintStyle:
                TextStyle(color: HexColor.fromHex('#BCBEC0'), fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex('#EBF0FF')),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex('#d7e0f9')),
            ),
          ),
          onChanged: widget.onValueChanged),
    );
  }
}
