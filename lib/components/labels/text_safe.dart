import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
// In order to use this you have to always set maxwidth for the parent

class TextSafeComponent extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final double textBoxWidth;
  final Function onTap;
  final String fallbackText;
  final String label;
  TextSafeComponent(
      {this.label,
      this.fallbackText = 'Unknown',
      this.onTap,
      this.text,
      this.style,
      this.color,
      this.textBoxWidth = textboxWidthMedium});
  @override
  Widget build(BuildContext context) {
    String finalLabel = '';
    if (label != null) finalLabel = label + ': ';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: textBoxWidth,
        child: Row(
          children: <Widget>[
            Text(
              finalLabel,
              style: style != null ? style : textStyleDefault,
            ),
            Text(
              (text == null || text == 'null') ? fallbackText : text,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: style != null
                  ? style.copyWith(color: color)
                  : textStyleDefault.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
