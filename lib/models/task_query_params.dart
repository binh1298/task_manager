

class TaskQueryParams {
  String beginAt, endAt, taskStatus, userId;

  TaskQueryParams({this.beginAt, this. endAt, this.taskStatus, this.userId});

  Map<String, String> toMap() {
    Map<String, String> map = {};
    if(beginAt != null) map.addAll({'beginAt': beginAt});
    if(endAt != null) map.addAll({'endAt': endAt});
    if(taskStatus != null && taskStatus != 'ALL') map.addAll({'taskStatus': taskStatus});
    if(userId != null) map.addAll({'userId': userId});
    return map;
  }

  factory TaskQueryParams.fromJson(dynamic json) {
    return TaskQueryParams(
      beginAt: json['beginAt'],
      endAt: json['endAt'],
      taskStatus: json['taskStatus'],
      userId: json['userId'],
    );
  }
}