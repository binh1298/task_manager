import 'package:intl/intl.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

bool isEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String getUserStatus(bool isDeleted) {
  return isDeleted ? 'Deleted' : 'Active';
}

String formatDate(String strDate) {
  if (strDate == null) return null;
  DateTime date = DateTime.parse(strDate);
  return DateFormat('yyyy-MM-dd').format(date);
}

List<String> taskStatuses = [
  'PENDING',
  'IN-PROGRESS',
  'ACCEPT',
  'DECLINE',
  'FINISHED',
  'FAILED',
  'OVERDUED'
];
List<String> creatableTaskStatuses = ['PENDING', 'IN-PROGRESS'];
List<String> updatatableTaskStatusesForManager = [
  'PENDING',
  'IN-PROGRESS',
  'ACCEPT',
  'DECLINE',
  'FINISHED',
  'FAILED'
];
List<String> updatatableTaskStatusesForUser = [
  'PENDING',
  'IN-PROGRESS',
  'FINISHED',
  'FAILED'
];

List<String> judgeStatuses = ['NOT-JUDGED', 'JUDGED'];

class RoleNames {
  static String admin = 'admin', manager = 'manager', employee = 'employee';
}

class TaskTypes {
  static String judge = 'judge', submit = 'submit';
}

