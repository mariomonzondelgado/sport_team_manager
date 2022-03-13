import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/store_image.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/util/string_value_util.dart';

class ContentRepository {
  // ADD
  static addPost(
      WidgetRef ref, String title, String body, StoreImage image) async {
    if (title.trim().isEmpty || body.trim().isEmpty || image.file == null) {
      ControllerToastMessages.messageFromError(you_must_add_an_image);
    } else {
      image.pathUrl = await ref
          .read(storageServiceProvider)
          .uploadImage('/news/${image.file.hashCode}', (image.file as File));
      Post newPost = Post(
          title: title,
          body: body,
          imageUrl: (image.pathUrl as String),
          postId: '',
          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
      await ref.read(databaseProvider).addPost(newPost);
    }
  }

  static addPlayer(WidgetRef ref, String firstName, String lastName,
      String position, String number, StoreImage photo) async {
    if (firstName.trim().isEmpty ||
        lastName.trim().isEmpty ||
        position.trim().isEmpty ||
        number.trim().isEmpty ||
        photo.file == null) {
      ControllerToastMessages.messageFromError(general_error);
    } else {
      photo.pathUrl = await ref
          .read(storageServiceProvider)
          .uploadImage('/roster/${photo.file.hashCode}', (photo.file as File));

      Player newPLayer = Player(
          playerId: '',
          firstName: firstName,
          lastName: lastName,
          number: number,
          position: position,
          photoUrl: (photo.pathUrl as String));

      await ref.read(databaseProvider).addPlayer(newPLayer);
    }
  }

  static addEvent(WidgetRef ref, String title, String body) async {
    if (title.trim().isEmpty || body.trim().isEmpty) {
      ControllerToastMessages.messageFromError(general_error);
    } else {
      Event newEvent = Event(
        eventId: '',
        title: title,
        body: body,
      );

      await ref.read(databaseProvider).addEvent(newEvent);
    }
  }

  // DELETE
  static deletePost(WidgetRef ref, String postId, String imageUrl) async {
    Logger().wtf('Post: $postId');
    await ref.read(databaseProvider).removePost(postId);
    await ref
        .read(storageServiceProvider)
        .deletePostImage(StoreImage.getImageHashCode(imageUrl));
  }

  static deletePlayer(WidgetRef ref, String playerId, String photoUrl) async {
    Logger().wtf('Player: $playerId');
    await ref.read(databaseProvider).removePlayer(playerId);
    await ref
        .read(storageServiceProvider)
        .deletePlayerPhoto(StoreImage.getImageHashCode(photoUrl));
  }

  static deleteEvent(WidgetRef ref, String eventId) async {
    Logger().wtf('Event: $eventId');
    await ref.read(databaseProvider).removeEvent(eventId);
  }

  // UPDATE
  static updatePost(WidgetRef ref, String postId, String title, String body,
      StoreImage image) async {
    if (title.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_title);
    } else if (body.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_description);
    } else {
      if (image.file != null) {
        await ref.read(storageServiceProvider).deletePostImage(
            StoreImage.getImageHashCode((image.pathUrl as String)));
        image.pathUrl = await ref
            .read(storageServiceProvider)
            .uploadImage("/news/${image.file.hashCode}", (image.file as File));
      }
      Post newPost = Post(
          title: title,
          body: body,
          imageUrl: (image.pathUrl.toString()),
          postId: postId,
          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
      await ref.read(databaseProvider).editPost(newPost, postId);
    }
  }

  static updatePlayer(WidgetRef ref, String playerId, String firstName,
      String lastName, String position, String number, StoreImage photo) async {
    try {
      if (photo.file != null) {
        await ref
            .read(storageServiceProvider)
            .deletePostImage(StoreImage.getImageHashCode((photo.pathUrl!)));
        photo.pathUrl = await ref.read(storageServiceProvider).uploadImage(
            "/roster/${photo.file.hashCode}", (photo.file as File));
      }
      Player newPlayer = Player(
          playerId: playerId,
          firstName: firstName,
          lastName: lastName,
          number: number,
          position: position,
          photoUrl: (photo.pathUrl.toString()));
      await ref.read(databaseProvider).editPlayer(newPlayer, playerId);
    } catch (e) {
      Logger().e(e);
    }
    // if (firstName.trim().isEmpty ||
    //     lastName.trim().isEmpty ||
    //     position.trim().isEmpty ||
    //     number.trim().isEmpty ||
    //     photo.file == null) {
    //   ControllerToastMessages.messageFromError(general_error);
    // } else {
    //   if (photo.file != null) {
    //     await storageService.deletePostImage(
    //         StoreImage.getImageHashCode((photo.pathUrl as String)));
    //     photo.pathUrl = await storageService.uploadImage(
    //         "/roster/${photo.file.hashCode}", (photo.file as File));
    //   }
    //   Player newPlayer = Player(
    //       playerId: playerId,
    //       firstName: firstName,
    //       lastName: lastName,
    //       number: number,
    //       position: position,
    //       photoUrl: (photo.pathUrl.toString()));
    //   await database.editPlayer(newPlayer, playerId);
    // }
  }

  static updateEvent(
    WidgetRef ref,
    String eventId,
    String title,
    String body,
  ) async {
    if (title.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_title);
    } else if (body.trim().isEmpty) {
      ControllerToastMessages.genericMessage(add_valid_description);
    } else {
      Event newEvent = Event(
        eventId: eventId,
        title: title,
        body: body,
      );
      await ref.read(databaseProvider).editEvent(newEvent, eventId);
    }
  }
}
