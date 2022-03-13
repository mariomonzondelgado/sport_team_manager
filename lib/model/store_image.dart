import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class StoreImage {
  File? file;
  String? pathUrl;

  StoreImage();

  StoreImage.fromFile({required this.file});

  StoreImage.fromUrl({required this.pathUrl});

  static Future<FilePickerResult?> chooseImageFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
  }

  static Future<XFile?> chooseImageFileFromCamera() async {
    ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  static getImageHashCode(String url) {
    String splitHashCode = url.split("?").elementAt(0).split("%").last;
    if (splitHashCode.contains("F")) {
      splitHashCode = splitHashCode.substring(
          splitHashCode.indexOf("F") + 1, splitHashCode.length);
    }
    return splitHashCode;
  }
}
