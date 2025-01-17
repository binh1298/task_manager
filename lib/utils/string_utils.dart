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

List<String> taskStatusesToQuery = [
  'ALL',
  ...taskStatuses,
];
List<String> taskStatuses = [
  'PENDING',
  'IN-PROGRESS',
  'ACCEPTED',
  'DECLINE',
  'FINISHED',
  'FAILED',
  'OVERDUE'
];
List<String> creatableTaskStatuses = ['PENDING', 'IN-PROGRESS'];

List<String> updatatableTaskStatusesForJudgeWithoutOverdue = [
  'PENDING',
  'IN-PROGRESS',
  'ACCEPTED',
  'DECLINE',
  'FINISHED',
  'FAILED',
]; 

List<String> updatatableTaskStatusesForJudge = [
  ...taskStatuses
];

List<String> updatatableTaskStatusesForAssignee = [
  'PENDING',
  'IN-PROGRESS',
  'FINISHED',
  'FAILED'
];

class JudgeStatus {
  static const String 
    judged = 'JUDGED',
    notJudged = 'NOT-JUDGED';
}
List<String> judgeStatuses = ['NOT-JUDGED', 'JUDGED'];

class RoleNames {
  static const String admin = 'admin', manager = 'manager', employee = 'employee';
}

class TaskTypesForQuery {
  static const String 
  judge = 'judge', 
  assignee = 'assignee',
  history = 'history';
}
