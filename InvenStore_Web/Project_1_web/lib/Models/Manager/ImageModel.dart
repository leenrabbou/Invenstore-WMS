// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel extends ChangeNotifier {
  File? _pickedImage1;
  File? _pickedImage2;
  File? _pickedImage3;
  Uint8List _webImage1 = Uint8List(8);
  Uint8List _webImage2 = Uint8List(8);
  Uint8List _webImage3 = Uint8List(8);

  File? get pickedImage1 => _pickedImage1;
  File? get pickedImage2 => _pickedImage2;
  File? get pickedImage3 => _pickedImage3;
  void emptyImage() {
    _pickedImage1 = null;
  }

  void setImage() {
    _pickedImage2 = _pickedImage1;
    _webImage2 = _webImage1;
    notifyListeners();
  }

  Uint8List get webImage1 => _webImage1;
  Uint8List get webImage2 => _webImage2;
  Uint8List get webImage3 => _webImage3;

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker pick = ImagePicker();
      XFile? image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = await image.readAsBytes();
        _pickedImage1 = File('a');
        _webImage1 = selected;
        notifyListeners();
      }
    }
  }

  Future<void> pickImage2() async {
    if (kIsWeb) {
      final ImagePicker pick = ImagePicker();
      XFile? image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = await image.readAsBytes();
        _pickedImage3 = File('b');
        _webImage3 = selected;
        notifyListeners();
      }
    }
  }

  void emptyImage3() {
    _pickedImage3 = null;
  }
}
