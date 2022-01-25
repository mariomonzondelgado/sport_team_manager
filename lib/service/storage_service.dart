import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  /// Select and image from the gallery or take a picture with the camera
  /// Then upload to Firebase Storage
  Future<void> upload(String inputSource, String route) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).child(route).putFile(imageFile);
      } on FirebaseException catch (error) {
        Logger().e(error);
      }
    } catch (err) {
      Logger().e(err);
    }
  }

  /// Retriew the uploaded images
  /// This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> loadImages(String route) async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().child(route).list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });

    return files;
  }

  /// Delete the selected image
  /// This function is called when a trash icon is pressed
  Future<void> delete(String ref, String route) async {
    await storage.ref(ref).child(route).delete();
  }
}

final fbStorageProvider = Provider((ref) => FirebaseStorageService());
