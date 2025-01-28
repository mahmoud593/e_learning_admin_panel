class PlacementModel {

  PlacementModel({
    required this.link,
    required this.uId,

  });

  final String link;
  final String uId;


  factory PlacementModel.fromMap(Map<String, dynamic> json) => PlacementModel(
    link: json["link"],
    uId: json["uId"],

  );

  Map<String, dynamic> toMap() => {
    "link": link,
    "uId": uId,

  };
}
