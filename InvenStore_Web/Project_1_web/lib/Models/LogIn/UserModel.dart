// ignore_for_file: file_names

class UserModel {
  UserModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.email,
      required this.token,
      required this.permissions,
      required this.roles,
      required this.goTo,
      required this.bans,
      required this.emailVerifiedAt});

  int id;
  String? image, token, goTo, emailVerifiedAt;
  List<String>? bans;
  String email, name;
  List<String>? roles;
  List<String>? permissions;
  factory UserModel.fromjson(jsonData) {
    return UserModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['image'],
      email: jsonData['email'],
      permissions: List<String>.from(jsonData['permissions']),
      roles: List<String>.from(jsonData['roles']),
      token: jsonData['token'],
      goTo: jsonData['go_to'],
      emailVerifiedAt: jsonData['email_verified_at'],
      bans: List<String>.from(jsonData['bans']),
    );
  }
}
