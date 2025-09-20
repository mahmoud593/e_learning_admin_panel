  class GroupModel {

    GroupModel({
      required this.endDate,
      required this.count,
      required this.endTime,
      required this.startDate,
      required this.startTime,
      required this.coursePrice,
      required this.uId,
      required this.courseName,
      required this.courseTime,
      required this.status,
  });

  final String endDate;
  final int count;
  final double coursePrice;
  final String endTime;
  final String startDate;
  final String courseName;
  final String courseTime;
  final String startTime;
  final String uId;
  final bool status;


  factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
    endDate: json["endDate"],
    count: json["count"],
    endTime: json["endTime"],
    coursePrice: json["coursePrice"],
    startDate: json["startDate"],
    courseName: json["courseName"]??'',
    startTime: json["startTime"],
    courseTime: json["courseTime"],
    uId: json["uId"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "endDate": endDate,
    "count": count,
    "endTime": endTime,
    "coursePrice": coursePrice,
    "startDate": startDate,
    "courseName": courseName,
    "courseTime": courseTime,
    "startTime": startTime,
    "uId": uId,
    "status": status,
  };
}
