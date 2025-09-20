class StudentModel {

  StudentModel({
    required this.board,
    required this.email,
    required this.groupId,
    required this.school,
    required this.parentName,
    required this.parentPhone,
    required this.studentName,
    required this.studentPhone,
    required this.session,
    required this.isPayment,
    required this.isVerify,
    required this.isVerifyCambridge,
    required this.isVerifyOxford,
    required this.isVerifyIlets,
    required this.uId,
  });

  final String board;
  final String email;
  final String groupId;
  final bool isPayment;
  final bool isVerify;
   bool isVerifyCambridge;
   bool isVerifyIlets;
   bool isVerifyOxford;
  final String parentName;
  final String parentPhone;
  final String school;
  final List<String> session;
  final String studentName;
  final String studentPhone;
  final String uId;

  factory StudentModel.fromMap(Map<String, dynamic> json) => StudentModel(
    board: json["board"],
    email: json["email"],
    groupId: json["groupId"],
    isPayment: json["isPayment"],
    isVerify: json["isVerify"],
    isVerifyIlets: json["isVerifyIlets"]?? false,
    isVerifyOxford: json["isVerifyOxford"]?? false,
    isVerifyCambridge: json["isVerifyCambridge"]?? false,
    parentName: json["parentName"],
    parentPhone: json["parentPhone"],
    school: json["school"],
    session: List<String>.from(json["session"].map((x) => x)),
    studentName: json["studentName"],
    studentPhone: json["studentPhone"],
    uId: json["uId"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "groupId": groupId,
    "isPayment": isPayment,
    "isVerify": isVerify,
    "isVerifyIlets": isVerifyIlets,
    "isVerifyOxford": isVerifyOxford,
    "isVerifyCambridge": isVerifyCambridge,
    "parentName": parentName,
    "parentPhone": parentPhone,
    "school": school,
    "session": session,
    "studentName": studentName,
    "studentPhone": studentPhone,
  };
}
