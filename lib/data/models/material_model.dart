class MaterialModel {

  MaterialModel({
    required this.title,
    required this.url,
    required this.uId,
    required this.date,
    this.isImage=false,

  });

  final String title;
  final String url;
  final String uId;
  final String date;
  bool isImage;


  factory MaterialModel.fromMap(Map<String, dynamic> json) => MaterialModel(
    title: json["title"],
    url: json["url"],
    uId: json["uId"],
    date: json["date"]??DateTime.now().toIso8601String(),
    isImage: json["isImage"]??true,

  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "url": url,
    "date": date,
    "uId": uId,
    "isImage": isImage,

  };
}
