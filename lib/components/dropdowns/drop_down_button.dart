import 'package:flutter/material.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/style/style.dart';

class DropdownFormFieldComponent extends StatefulWidget {
  final String title;
  final Function updateState;
  final List<String> options;
  final TextStyle style;
  final String initialValue;
  DropdownFormFieldComponent(
      {this.initialValue, this.title, this.updateState, this.options, this.style});

  @override
  _DropdownFormFieldComponentState createState() =>
      _DropdownFormFieldComponentState();
}

class _DropdownFormFieldComponentState
    extends State<DropdownFormFieldComponent> {
  String dropDownOption;

  @override
  void initState() {
    super.initState();
    dropDownOption = widget.initialValue == null? widget.options[0] : widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextSafeComponent(
          text: widget.title,
          style: textStyleTitle,
        ),
        DropdownButton<String>(
          value: dropDownOption,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: colorPrimary,
          ),
          isExpanded: true,
          style: widget.style,
          onChanged: (String newString) {
            setState(() {
              dropDownOption = newString;
            });
            widget.updateState(newString);
          },
          items: widget.options
              .map<DropdownMenuItem<String>>(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: textStyleDefault.copyWith(
                        color: getTaskStatusColor(option)),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
