import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  final String label;
  final Function onSaved;
  DateFormField({this.label, this.onSaved});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          DateTimeField(
            format: format,
            validator: (value) {
              if (value == null) {
                return 'Please choose a date';
              }
              return null;
            },
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
            onSaved: onSaved,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
