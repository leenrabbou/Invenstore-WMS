// ignore_for_file: file_names

class StateModel {
  int id, cityId;
  String name, nameEn, nameAr, city;
  StateModel(
      {required this.name,
      required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.city,
      required this.cityId});
  factory StateModel.fromjson(jsonData) {
    return StateModel(
      id: jsonData['id'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
      city: jsonData['city'],
      cityId: jsonData['city_id'],
    );
  }
}
