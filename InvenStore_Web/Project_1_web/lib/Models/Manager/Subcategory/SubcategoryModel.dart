// ignore_for_file: file_names

class SubCategoryModel {
  String? image;
  String name, nameEn, nameAr, category;
  int id, categoryId;
  SubCategoryModel({
    required this.image,
    required this.name,
    required this.category,
    required this.categoryId,
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory SubCategoryModel.fromjson(jsonData) {
    return SubCategoryModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
      categoryId: jsonData['category_id'],
      category: jsonData['category'],
    );
  }
}
