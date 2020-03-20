

class TaskQueryParams {
  String from, to, status, fullname;

  TaskQueryParams({this.from, this. to, this.status, this.fullname});

  Map<String, String> toMap() {
    return {
      'from': from,
      'to': to,
      'status': status,
      'fullname': fullname,
    };
  }

  factory TaskQueryParams.fromJson(dynamic json) {
    return TaskQueryParams(
      from: json['from'],
      to: json['to'],
      status: json['status'],
      fullname: json['fullname'],
    );
  }
}