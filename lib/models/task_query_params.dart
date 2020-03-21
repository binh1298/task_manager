

class TaskQueryParams {
  String from, to, status, userId;

  TaskQueryParams({this.from, this. to, this.status, this.userId});

  Map<String, String> toMap() {
    return {
      'from': from,
      'to': to,
      'status': status,
      'userId': userId,
    };
  }

  factory TaskQueryParams.fromJson(dynamic json) {
    return TaskQueryParams(
      from: json['from'],
      to: json['to'],
      status: json['status'],
      userId: json['userId'],
    );
  }
}