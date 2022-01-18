import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/sponsor_model.dart';

class Database {
  final _events = FirebaseFirestore.instance.collection('events');
  final _news = FirebaseFirestore.instance.collection('news');
  final _sponsors = FirebaseFirestore.instance.collection('sponsors');
  final _roster = FirebaseFirestore.instance.collection('roster');

  //READ
  Stream get allNews => _news.snapshots();
  Stream get allEvents => _events.snapshots();
  Stream get allRoster => _roster.snapshots();
  Stream get allSponsors => _sponsors.snapshots();

  //CREATE
  Future<bool> addPost(Post post) async {
    try {
      await _news.add(post.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addEvent(Event event) async {
    try {
      await _events.add(event.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addPlayer(Player player) async {
    try {
      await _roster.add(player.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addSponsor(Sponsor sponsor) async {
    try {
      await _sponsors.add(sponsor.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  //DELETE

  Future<bool> removePost(String postId) async {
    try {
      await _news
          .doc(postId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      Logger().e(e);
      return Future.error(e); // return error
    }
  }

  Future<bool> removeEvent(String eventId) async {
    try {
      await _events
          .doc(eventId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      Logger().e(e);
      return Future.error(e); // return error
    }
  }

  Future<bool> removePlayer(String playerId) async {
    try {
      await _roster
          .doc(playerId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      Logger().e(e);
      return Future.error(e); // return error
    }
  }

  Future<bool> removeSponsor(String sponsorId) async {
    try {
      await _sponsors
          .doc(sponsorId)
          .delete(); // deletes the document with id of movieId from our movies collection
      return true; // return true after successful deletion .
    } catch (e) {
      Logger().e(e);
      return Future.error(e); // return error
    }
  }

  //UPDATE
  Future<bool> editPost(Post post, String postId) async {
    try {
      await _news.doc(postId).update(post.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return Future.error(e);
    }
  }

  Future<bool> editEvent(Event event, String eventId) async {
    try {
      await _events.doc(eventId).update(event.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return Future.error(e);
    }
  }

  Future<bool> editPlayer(Player player, String playerId) async {
    try {
      await _roster.doc(playerId).update(player.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return Future.error(e);
    }
  }

  Future<bool> editSponsor(Sponsor sponsor, String sponsorId) async {
    try {
      await _sponsors.doc(sponsorId).update(sponsor.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return Future.error(e);
    }
  }
}
