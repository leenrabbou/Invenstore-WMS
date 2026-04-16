class NotificationModel {
  String messageAr;
  String messageEn;

  NotificationModel({required this.messageAr, required this.messageEn});

  factory NotificationModel.fromjson(jsonData) {
    return NotificationModel(
      messageAr: jsonData['message_ar'],
      messageEn: jsonData['message_en'],
    );
  }
}
