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
Color colorCancel = Colors.blueGrey[300];
Color colorInactive = Colors.grey;
Color colorError = Colors.red;
const Color colorTextDefault = Colors.black;
Color colorAccept = Colors.green;
Color colorWarning = Colors.redAccent.shade400;

Color colorTaskPending = Colors.cyan;
Color colorTaskInProgress = Colors.blue;
Color colorTaskFinished = Colors.green;
Color colorTaskOverdue = Colors.red;
Color colorTaskFailed = Colors.red;

// Textbox Width
const double textboxWidthMedium = 220.0;
const double textboxWidthLarge = 280.0;

// Functions
Color getUserStatusColor(bool isDeleted) {
  return isDeleted ? colorError : colorAccept;
}

class TaskStatus {
  final String status;
  final Color color;
  TaskStatus({this.status, this.color});
}

List<TaskStatus> taskStatusesWithColor = <TaskStatus>[
  TaskStatus(status: 'PENDING', color: colorTaskPending),
  TaskStatus(status: 'IN-PROGRESS', color: colorTaskInProgress),
  TaskStatus(status: 'FINISHED', color: colorTaskFinished),
  TaskStatus(status: 'ACCEPT', color: colorTaskFinished),
  TaskStatus(status: 'OVERDUE', color: colorTaskOverdue),
  TaskStatus(status: 'FAILED', color: colorTaskFailed),
  TaskStatus(status: 'DECLINE', color: colorTaskFailed),
];
Color getTaskStatusColor(String status) {
  for (var task in taskStatusesWithColor) {
    if(task.status == status) return task.color;
  }
  return colorTextDefault;
}