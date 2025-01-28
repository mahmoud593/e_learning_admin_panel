class UserModel {

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.email,
    required this.group,
    required this.course,
  });

  final String id;
  final String name;
  final String image;
  final String phone;
  final String email;
  final String group;
  final String course;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    phone: json["phone"],
    email: json["email"],
    group: json["group"],
    course: json["course"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "phone": phone,
    "email": email,
    "group": group,
    "course": course,
  };
}
