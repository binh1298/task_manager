import 'package:flutter/material.dart';

// Text
const TextStyle textStyleDefault = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
TextStyle textStyleHeading = textStyleDefault.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
);
TextStyle textStyleTitle = textStyleDefault.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
);
TextStyle textStyleSubtitle = textStyleDefault.copyWith(
  fontSize: 20.0,
);

TextStyle textStyleErrorMessage = TextStyle(color: colorError); 

// Color
Color colorPrimary = Colors.blue;
Color colorBackground = Colors.white;
Color colorCancel = Colors.blueGrey[100];
Color colorInactive = Colors.grey;
Color colorError = Colors.red;
const Color colorTextDefault = Colors.black;
Color colorAccept = Colors.green;
Color colorWarning = Colors.redAccent.shade400;

// Textbox Width
const double textboxWidthMedium = 220.0;
const double textboxWidthLarge = 280.0;
