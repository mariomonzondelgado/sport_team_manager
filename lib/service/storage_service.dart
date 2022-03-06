import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<String> uploadImage(String path, File file) async {
    Reference reference = _storageReference.child(path);
    UploadTask uploadTask = reference.putFile(file);
    await uploadTask;
    return await reference.getDownloadURL();
  }

  Future<void> deletePostImage(String title) async {
    return FirebaseStorage.instance
        .refFromURL('gs://telde-canes.appspot.com/news/$title')
        .delete();
  }

  Future<void> deletePlayerPhoto(String title) async {
    return FirebaseStorage.instance
        .refFromURL('gs://telde-canes.appspot.com/roster/$title')
        .delete();
  }
}
