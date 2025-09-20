class PlacementModel {

  PlacementModel({
    required this.link,
    required this.uId,
    required this.title,
    required this.date,
     this.isImage=true,

  });

  final String link;
  final String uId;
  final String title;
  final String date;
  bool isImage;


  factory PlacementModel.fromMap(Map<String, dynamic> json) => PlacementModel(
    link: json["link"],
    uId: json["uId"],
    title: json["title"],
    date: json["date"]??DateTime.now().toIso8601String(),
    isImage: json["isImage"]??true,

  );

  Map<String, dynamic> toMap() => {
    "link": link,
    "uId": uId,
    "title": title,
    "date": date,
    "isImage": isImage,

  };
}
