// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel extends ChangeNotifier {
  File? _pickedImage1;
  Uint8List _webImage1 = Uint8List(8);

  File? get pickedImage1 => _pickedImage1;
  void emptyImage() {
    _pickedImage1 = null;
  }

  Uint8List get webImage1 => _webImage1;

  Future<void> pickImage() async {
    final ImagePicker pick = ImagePicker();
    XFile? image = await pick.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        var selected = await image.readAsBytes();
        _pickedImage1 = File('a');
        _webImage1 = selected;
        notifyListeners();
      } else {
        _pickedImage1 = File(image.path);
      }
    }
  }

  void emptyImage3() {
    _pickedImage1 = null;
  }
}
