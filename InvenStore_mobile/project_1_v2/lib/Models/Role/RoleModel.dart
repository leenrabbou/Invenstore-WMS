// ignore_for_file: file_names

class RoleModel {
  String name;
  int id;
  RoleModel({
    required this.id,
    required this.name,
  });

  factory RoleModel.fromjson(jsonData) {
    return RoleModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
