import 'package:intl/intl.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

bool isEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

String getUserStatus(bool isDeleted) {
  return isDeleted ? 'Deleted' : 'Active';
}

String formatDate(String strDate) {
  DateTime date = DateTime.parse(strDate);
  return DateFormat('yyyy-MM-dd').format(date);
}

List<String> creatableTaskStatuses = ['PENDING', 'IN-PROGRESS']; 