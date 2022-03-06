import 'dart:io';

import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/service/database.dart';
import 'package:sport_team_manager/service/storage_service.dart';
import 'package:sport_team_manager/util/string_value_util.dart';

class Admin extends Person {
  Admin.fromDB({
    required String firstName,
    required String lastName,
    required String email,
    required bool isAdmin,
  }) : super.fromDB(
            firstName: firstName,
            lastName: lastName,
            email: email,
            isAdmin: isAdmin);
  Admin(
      {required String firstName,
      required String lastName,
      required String email})
      : super(firstName: firstName, lastName: lastName, email: email);

  addPost(String title, String body, StoreImage image) async {
    if (title.trim().isEmpty) {
      ControllerToastMessages.messageFromError(add_valid_title);
    } else if (body.trim().isEmpty) {
      ControllerToastMessages.messageFromError(add_valid_description);
    } else if (image.file == null) {
      ControllerToastMessages.messageFromError(you_must_add_an_image);
    } else {
      StorageService storageService = StorageService();
      Database database = Database();
      image.pathUrl = await storageService.uploadImage(
          "/news/${image.file.hashCode}", (image.file as File));
      Post newPost = Post(
          title: title,
          body: body,
          imageUrl: (image.pathUrl as String),
          postId: "",
          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
      await database.addPost(newPost);
    }
  }

  deletePost(String postId, String imageUrl) async {
    Database database = Database();
    StorageService storageService = StorageService();
    await database.removePost(postId);
    await storageService.deletePostImage(StoreImage.getImageHashCode(imageUrl));
  }

  updatePost(String postId, String title, String body, StoreImage image) async {
    if (title.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_title);
    } else if (body.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_description);
    } else {
      Database database = Database();
      StorageService storageService = StorageService();
      if (image.file != null) {
        await storageService.deletePostImage(
            StoreImage.getImageHashCode((image.pathUrl as String)));
        image.pathUrl = await storageService.uploadImage(
            "/news/${image.file.hashCode}", (image.file as File));
      }
      Post newPost = Post(
          title: title,
          body: body,
          imageUrl: (image.pathUrl.toString()),
          postId: postId,
          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
      await database.editPost(newPost, postId);
    }
  }
}
