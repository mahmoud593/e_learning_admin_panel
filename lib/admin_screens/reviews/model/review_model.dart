class ReviewModel {

  ReviewModel({
    required this.review,
    required this.reviewImage,
    required this.userImage,
    required this.userName,
    required this.uId,
  });

  final String review;
  final String reviewImage;
  final String userImage;
  final String userName;
  final String uId;


  factory ReviewModel.fromMap(Map<String, dynamic> json) => ReviewModel(
    review: json["review"],
    reviewImage: json["reviewImage"],
    userImage: json["userImage"],
    userName: json["userName"],
    uId: json["uId"],

  );

  Map<String, dynamic> toMap() => {
    "reviewImage": reviewImage,
    "review": review,
    "userImage": userImage,
    "userName": userName,
    "uId": uId,
  };
}
