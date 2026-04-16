// ignore_for_file: file_names

class ProductModel {
  int id, manufacturerId, subcategoryId;
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
  String? barcode;
  ProductModel({
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
    required this.barcode,
  });

  factory ProductModel.fromjson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      nameEn: jsonData['name_en'],
      nameAr: jsonData['name_ar'],
      price: jsonData['price'],
      description: jsonData['description'],
      descriptionEn: jsonData['description_en'],
      descriptionAr: jsonData['description_ar'],
      manufacturer: jsonData['manufacturer'],
      subcategory: jsonData['subcategory'],
      subcategoryId: jsonData['subcategory_id'],
      manufacturerId: jsonData['manufacturer_id'],
      barcode: jsonData['barcode'],
    );
  }
}
