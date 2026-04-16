// ignore_for_file: file_names

class StoredProductModel {
  int id, manufacturerId, subcategoryId, max;
  int? active, validQuantity;
  String? image, expirationDate;
  String name,
      nameEn,
      nameAr,
      manufacturer,
      description,
      descriptionAr,
      descriptionEn,
      subcategory;
  double price;
  StoredProductModel({
    required this.id,
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
    required this.max,
    required this.active,
    required this.expirationDate,
    required this.validQuantity,
  });

  factory StoredProductModel.fromjson(jsonData) {
    return StoredProductModel(
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
      max: jsonData['max'],
      expirationDate: jsonData['expiration_date'],
      validQuantity: jsonData['valid_quantity'],
      active: jsonData['active'],
    );
  }
}
