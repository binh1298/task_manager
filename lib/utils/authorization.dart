import 'package:flutter/material.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/utils/secure_storage.dart';

logout(BuildContext context) {
  deleteAllFromSecureStorage().then(
    (onValue) => RestartWidget.restartApp(context),
  );
}
