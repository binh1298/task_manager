import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
// In order to use this you have to always set maxwidth for the parent

class TextSafeComponent extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle labelStyle;
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
      this.labelStyle,
      this.color,
      this.textBoxWidth = textboxWidthMedium});
  @override
  Widget build(BuildContext context) {
    String finalLabel = '';
    if (label != null) finalLabel = label + ': ';
    String finalFallBackText = fallbackText != null ? fallbackText : 'Unknown';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: textBoxWidth,
        child: Wrap(
          children: <Widget>[
            Text(
              finalLabel,
              style: labelStyle != null ? labelStyle : style != null ? style : textStyleDefault,
            ),
            Text(
              (text == null || text == 'null') ? finalFallBackText : text,
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
