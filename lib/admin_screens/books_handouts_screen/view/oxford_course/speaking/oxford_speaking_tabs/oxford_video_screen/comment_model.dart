class CommentsModel {

  CommentsModel({
    required this.comment,
    required this.imageUrl,
    required this.name,
    required this.uId,

  });

  final String comment;
  final String imageUrl;
  final String name;
  final String uId;


  factory CommentsModel.fromMap(Map<String, dynamic> json) => CommentsModel(
    comment: json["comment"],
    imageUrl: json["imageUrl"],
    name: json["name"],
    uId: json["uId"],

  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "imageUrl": imageUrl,
    "comment": comment,
    "uId": uId,

  };
}
