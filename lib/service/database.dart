import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/sponsor_model.dart';

class Database {
  final _events = FirebaseFirestore.instance.collection('events');
  final _news = FirebaseFirestore.instance.collection('news');
  final _sponsors = FirebaseFirestore.instance.collection('sponsors');
  final _roster = FirebaseFirestore.instance.collection('roster');
  final _members = FirebaseFirestore.instance.collection('members');

  //READ

  Stream<QuerySnapshot> get allNews => _news.snapshots();
  Stream<QuerySnapshot> get allEvents => _events.snapshots();
  Stream<QuerySnapshot> get allRoster => _roster.snapshots();
  Stream<QuerySnapshot> get allSponsors => _sponsors.snapshots();
  Stream<QuerySnapshot> get allMembers => _members.snapshots();

  Future<bool> checkIfUserExistsInDB(String email) async {
    bool exists = false;
    QuerySnapshot snapshot = await _members.get();
    for (var document in snapshot.docs) {
      if (document["email"] == email) {
        exists = true;
      }
    }
    return exists;
  }

  Future<bool> getMemberAdminStatus(String memberId) async {
    final snapshot = await _members.doc(memberId).get();
    return snapshot.data()!["isAdmin"];
  }

  //CREATE

  Future<bool> addMember(Person person, String uid) async {
    try {
      await _members.doc(uid).set(person.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addPost(Post post) async {
    try {
      DocumentReference reference = _news.doc();
      post.postId = reference.id;
      await reference.set(post.toJson());
      //await _news.add(post.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addEvent(Event event) async {
    DocumentReference reference = _events.doc();
    // event.eventId = reference.id;
    try {
      await reference.set(event.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addPlayer(Player player) async {
    DocumentReference reference = _roster.doc();
    player.playerId = reference.id;
    try {
      await reference.set(player.toJson());
      return true;
    } catch (e) {
      return Future.error(e); // return error
    }
  }

  Future<bool> addSponsor(Sponsor sponsor) async {
    DocumentReference reference = _sponsors.doc();
    sponsor.sponsorId = reference.id;
    try {
      await reference.set(sponsor.toJson());
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
      Logger().wtf('Remote Post ==> $postId');
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
      Logger().wtf('Remote Player ==> $playerId');
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
      await _roster.doc(playerId).set(player.toJson());
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
