import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

// molde do usuario vindo da api
class User {
  int id;
  String name;
  String username;
  String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  // converte o json da api para o objeto User
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
      );

  // transforma o objeto User em json para salvar se precisar
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
      };
}
