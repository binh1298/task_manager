import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

bool isEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

String getUserStatus(bool isDeleted) {
  return isDeleted ? 'Deleted' : 'Active';
}

Color getUserStatusColor(bool isDeleted) {
  return isDeleted ? colorError : colorAccept;
}