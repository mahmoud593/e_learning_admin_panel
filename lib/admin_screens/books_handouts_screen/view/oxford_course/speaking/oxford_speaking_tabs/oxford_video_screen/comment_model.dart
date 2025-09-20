class CommentsModel {

  CommentsModel({
    required this.comment,
    required this.imageUrl,
    required this.userName,
    required this.id,

  });

  final String comment;
  final String imageUrl;
  final String userName;
  final String id;


  factory CommentsModel.fromMap(Map<String, dynamic> json) => CommentsModel(
    comment: json["comment"],
    imageUrl: json["imageUrl"]??'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    userName: json["userName"],
    id: json["id"],

  );

  Map<String, dynamic> toMap() => {
    "userName": userName,
    "imageUrl": imageUrl,
    "comment": comment,
    "id": id,

  };
}
