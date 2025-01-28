  class GroupModel {

    GroupModel({
      required this.endDate,
      required this.count,
      required this.endTime,
      required this.startDate,
      required this.startTime,
      required this.uId,
      required this.courseName,
      required this.status,
  });

  final String endDate;
  final int count;
  final String endTime;
  final String startDate;
  final String courseName;
  final String startTime;
  final String uId;
  final bool status;


  factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
    endDate: json["endDate"],
    count: json["count"],
    endTime: json["endTime"],
    startDate: json["startDate"],
    courseName: json["courseName"],
    startTime: json["startTime"],
    uId: json["uId"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "endDate": endDate,
    "count": count,
    "endTime": endTime,
    "startDate": startDate,
    "courseName": courseName,
    "startTime": startTime,
    "uId": uId,
    "status": status,
  };
}
