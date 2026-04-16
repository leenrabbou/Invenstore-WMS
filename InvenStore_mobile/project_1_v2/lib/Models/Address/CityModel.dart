// ignore_for_file: file_names

class CityModel {
  int id;
  String name, nameEn, nameAr;
  CityModel({
    required this.name,
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });
  factory CityModel.fromjson(jsonData) {
    return CityModel(
      id: jsonData['id'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
    );
  }
}
