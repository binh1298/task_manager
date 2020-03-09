import 'package:flutter/material.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/utils/secure_storage.dart';

Future<void> logout(BuildContext context) async {
  await removeJwtToken();
  RestartWidget.restartApp(context);
}
