class ProfileModel {
  int id;
  String? image;
  String userName, email, role;
  int roleId;

  ProfileModel({
    required this.id,
    required this.image,
    required this.userName,
    required this.email,
    required this.roleId,
    required this.role,
  });
  factory ProfileModel.fromjson(jsonData) {
    return ProfileModel(
      id: jsonData['id'],
      image: jsonData['image'],
      userName: jsonData['username'],
      email: jsonData['email'],
      roleId: jsonData['role_id'],
      role: jsonData['role'],
    );
  }
}
