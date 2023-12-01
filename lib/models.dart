class User {
  String? id;
  String? name;
  String? email;
  String? role;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}
