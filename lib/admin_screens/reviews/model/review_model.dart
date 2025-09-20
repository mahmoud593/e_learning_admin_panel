class ReviewModel {
  String? id;
  String? uId;
  String? userName;
  String? userImage;
  String? review;
  String? reviewImage;
  String? fcmToken;
  String? mediaType;
  String? reviewVideo; // إضافة حقل الفيديو
  String? createdAt;
  int? updatedAt; // إضافة تاريخ التحديث

  ReviewModel({
    this.id,
    this.uId,
    this.userName,
    this.userImage,
    this.review,
    this.reviewImage,
    this.reviewVideo,
    this.createdAt,
    this.fcmToken,
    this.mediaType,
    this.updatedAt,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    uId = json['uId']??'';
    userName = json['userName']??'';
    userImage = json['userImage']??'';
    review = json['review']??'';
    fcmToken = json['fcmToken']??'';
    mediaType = json['mediaType']??'';
    reviewImage = json['reviewImage']??'';
    reviewVideo = json['reviewVideo']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uId': uId,
      'userName': userName,
      'userImage': userImage,
      'mediaType': mediaType,
      'review': review,
      'fcmToken': fcmToken,
      'reviewImage': reviewImage,
      'reviewVideo': reviewVideo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // إضافة دالة copyWith للتحديث
  ReviewModel copyWith({
    String? id,
    String? uId,
    String? userName,
    String? userImage,
    String? review,
    String? reviewImage,
    String? fcmToken,
    String? reviewVideo,
    String? createdAt,
    int? updatedAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      uId: uId ?? this.uId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      review: review ?? this.review,
      fcmToken: review ?? this.fcmToken,
      reviewImage: reviewImage ?? this.reviewImage,
      reviewVideo: reviewVideo ?? this.reviewVideo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}