// ignore_for_file: file_names

class DestructionCausesModel {
  String name;
  int id;
  DestructionCausesModel({
    required this.id,
    required this.name,
  });

  factory DestructionCausesModel.fromjson(jsonData) {
    return DestructionCausesModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
