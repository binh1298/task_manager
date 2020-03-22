import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  final String label;
  final Function validator;
  final Function onSaved;
  final bool isAllowPast;
  DateFormField({this.validator, this.label, this.onSaved, this.isAllowPast = true});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return Expanded(
      child: Container(
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
              validator: validator,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: isAllowPast ? DateTime(1900) : DateTime.now(),
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
      ),
    );
  }
}
