// ignore_for_file: file_names

class ItemModel {
  final String name, image;
  void Function()? onTap;
  ItemModel({required this.name, required this.image, required this.onTap});
}
