// ignore_for_file: file_names

class ManufacturerModel {
  int id;
  String name,
      nameAr,
      nameEn,
      city,
      state,
      streetAddress,
      streetAddressAr,
      streetAddressEn;
  int stateId;

  ManufacturerModel({
    required this.id,
    required this.stateId,
    required this.name,
    required this.city,
    required this.nameAr,
    required this.nameEn,
    required this.state,
    required this.streetAddress,
    required this.streetAddressAr,
    required this.streetAddressEn,
  });
  factory ManufacturerModel.fromjson(jsonData) {
    return ManufacturerModel(
      id: jsonData['id'],
      stateId: jsonData['state_id'],
      name: jsonData['name'],
      nameAr: jsonData['name_ar'],
      nameEn: jsonData['name_en'],
      city: jsonData['city'],
      streetAddress: jsonData['street_address'],
      streetAddressAr: jsonData['street_address_ar'],
      streetAddressEn: jsonData['street_address_en'],
      state: jsonData['state'],
    );
  }
}
