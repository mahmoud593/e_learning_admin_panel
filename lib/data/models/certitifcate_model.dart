class CertitifcateModel {

  CertitifcateModel({
    required this.certificateImage,
    required this.certificateLink,
    required this.certificateName,
    required this.uId,
  });

  final String certificateImage;
  final String certificateLink;
  final String certificateName;
  final String uId;


  factory CertitifcateModel.fromMap(Map<String, dynamic> json) => CertitifcateModel(
    certificateImage: json["certificateImage"],
    certificateLink: json["certificateLink"],
    certificateName: json["certificateName"],
    uId: json["uId"],

  );

  Map<String, dynamic> toMap() => {
    "certificateImage": certificateImage,
    "certificateLink": certificateLink,
    "certificateName": certificateName,
    "uId": uId,
  };
}
