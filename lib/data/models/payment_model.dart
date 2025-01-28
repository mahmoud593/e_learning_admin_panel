class PaymentModel {

  PaymentModel({
    required this.image,
    required this.parentName,
    required this.parentPhone,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.paymentId,
    required this.userId,

  });

  final String image;
  final String parentName;
  final String parentPhone;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String paymentId;
  final String userId;


  factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
    image: json["image"],
    parentName: json["parentName"],
    parentPhone: json["parentPhone"],
    userEmail: json["userEmail"],
    userName: json["userName"],
    userPhone: json["userPhone"],
    paymentId: json["paymentId"],
    userId: json["userId"],

  );

  Map<String, dynamic> toMap() => {
    "image": image,
    "parentName": parentName,
    "parentPhone": parentPhone,
    "userEmail": userEmail,
    "userName": userName,
    "userPhone": userPhone,
    "paymentId": paymentId,
    "userId": userId,
  };
}
