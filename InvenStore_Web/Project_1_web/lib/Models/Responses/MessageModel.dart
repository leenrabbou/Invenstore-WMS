// ignore_for_file: file_names

class MessageModel {
  List<String>? nameAr;
  List<String>? nameEn;

  MessageModel({this.nameAr, this.nameEn});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      nameAr: json['name_ar'] != null ? List<String>.from(json['name_ar']) : [],
      nameEn: json['name_en'] != null ? List<String>.from(json['name_en']) : [],
    );
  }
}
