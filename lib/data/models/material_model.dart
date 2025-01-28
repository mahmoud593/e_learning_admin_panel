class MaterialModel {

  MaterialModel({
    required this.title,
    required this.url,
    required this.uId,

  });

  final String title;
  final String url;
  final String uId;


  factory MaterialModel.fromMap(Map<String, dynamic> json) => MaterialModel(
    title: json["title"],
    url: json["url"],
    uId: json["uId"],

  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "url": url,
    "uId": uId,

  };
}
