// ignore_for_file: file_names

class AllProductModel {
  int id, manufacturerId, subcategoryId, min;
  String? image;
  String name,
      nameEn,
      nameAr,
      manufacturer,
      description,
      descriptionAr,
      descriptionEn,
      subcategory;
  double price;
  int total;
  AllProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.nameEn,
      required this.nameAr,
      required this.price,
      required this.description,
      required this.descriptionEn,
      required this.descriptionAr,
      required this.manufacturer,
      required this.manufacturerId,
      required this.subcategory,
      required this.subcategoryId,
      required this.min,
      required this.total});

  factory AllProductModel.fromjson(jsonData) {
    return AllProductModel(
        id: jsonData['id'],
        image: jsonData['image'],
        name: jsonData['name'],
        nameEn: jsonData['name_en'],
        nameAr: jsonData['name_ar'],
        price: (jsonData['price'] as num).toDouble(),
        description: jsonData['description'],
        descriptionEn: jsonData['description_en'],
        descriptionAr: jsonData['description_ar'],
        manufacturer: jsonData['manufacturer'],
        subcategory: jsonData['subcategory'],
        subcategoryId: jsonData['subcategory_id'],
        manufacturerId: jsonData['manufacturer_id'],
        total: jsonData['total_quantity'],
        min: jsonData['min_quantity']);
  }
}
