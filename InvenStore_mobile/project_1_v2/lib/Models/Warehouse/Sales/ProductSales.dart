// ignore_for_file: file_names

class ProductSalesModel {
  int id, productId, manufacturerId, subcategoryId, quantity;
  String? image, expirationDate;
  String name,
      nameAr,
      nameEn,
      description,
      descriptionAr,
      descriptionEn,
      manufacturer,
      subcategory;
  double price;

  ProductSalesModel({
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
    required this.productId,
    required this.quantity,
    required this.expirationDate,
  });

  factory ProductSalesModel.fromjson(jsonData) {
    return ProductSalesModel(
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
        quantity: jsonData['quantity'],
        productId: jsonData['product_id'],
        expirationDate: jsonData['expiration_date']);
  }
}
