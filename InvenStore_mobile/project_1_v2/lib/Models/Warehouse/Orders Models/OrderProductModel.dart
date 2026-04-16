// ignore_for_file: file_names

class OrderProductModel {
  int id, productId, subcategoryId, quantity, manufacturerId;
  String? image;
  String name,
      nameEn,
      nameAr,
      manufacturer,
      description,
      descriptionAr,
      descriptionEn,
      subcategory,
      expirationDate;
  double cost;
  OrderProductModel({
    required this.image,
    required this.name,
    required this.quantity,
    required this.cost,
    required this.description,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.expirationDate,
    required this.manufacturer,
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.productId,
    required this.subcategory,
    required this.subcategoryId,
    required this.manufacturerId,
  });

  factory OrderProductModel.fromjson(jsonData) {
    return OrderProductModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
      cost: (jsonData['cost'] as num).toDouble(),
      description: jsonData['description'],
      descriptionEn: jsonData['description_en'],
      descriptionAr: jsonData['description_ar'],
      manufacturer: jsonData['manufacturer'],
      manufacturerId: jsonData['manufacturer_id'],
      subcategory: jsonData['subcategory'],
      subcategoryId: jsonData['subcategory_id'],
      expirationDate: jsonData['expiration_date'],
      quantity: jsonData['quantity'],
      productId: jsonData['product_id'],
    );
  }
}
