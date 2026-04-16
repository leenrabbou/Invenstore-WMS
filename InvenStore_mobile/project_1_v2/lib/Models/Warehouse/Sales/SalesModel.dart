// ignore_for_file: file_names

class SalesModel {
  int id;
  String? saledByImage;
  String saleNum, buyerName, saledAt, saledByName;
  double totalPrice;

  SalesModel({
    required this.id,
    required this.buyerName,
    required this.saleNum,
    required this.saledAt,
    required this.saledByImage,
    required this.saledByName,
    required this.totalPrice,
  });

  factory SalesModel.fromjson(jsonData) {
    return SalesModel(
      id: jsonData['id'],
      saleNum: jsonData['sale_num'],
      buyerName: jsonData['buyer_name'],
      saledAt: jsonData['saled_at'],
      saledByImage: jsonData['saled_by_image'],
      saledByName: jsonData['saled_by_name'],
      totalPrice: (jsonData['total_price'] as num).toDouble(),
    );
  }
}
