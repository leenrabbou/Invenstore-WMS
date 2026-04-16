// ignore_for_file: file_names

class WarehouseModel {
  int id;
  String? image;
  String name;
  String nameAr;
  String nameEn;
  String city;
  int stateId;
  String state;
  String streetAddress;
  String streetAddressAr;
  String streetAddressEn;

  WarehouseModel({
    required this.id,
    required this.image,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.city,
    required this.stateId,
    required this.state,
    required this.streetAddress,
    required this.streetAddressAr,
    required this.streetAddressEn,
  });

  factory WarehouseModel.fromjson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      city: json['city'],
      stateId: json['state_id'],
      state: json['state'],
      streetAddress: json['street_address'],
      streetAddressAr: json['street_address_ar'],
      streetAddressEn: json['street_address_en'],
    );
  }
}
