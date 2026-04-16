// ignore_for_file: file_names

class CategoryModel {
  CategoryModel(
      {required this.id,
      required this.name,
      required this.nameEn,
      required this.nameAr});
  int id;
  String name, nameEn, nameAr;

  factory CategoryModel.fromjson(jsonData) {
    return CategoryModel(
      id: jsonData['id'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
    );
  }
}
