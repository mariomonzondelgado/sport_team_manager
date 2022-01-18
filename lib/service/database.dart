import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/model/post_model.dart';
import 'package:sport_team_manager/model/sponsor_model.dart';

class Database {
  final events = FirebaseFirestore.instance.collection('events');
  final news = FirebaseFirestore.instance.collection('news');
  final sponsors = FirebaseFirestore.instance.collection('sponsors');
  final roster = FirebaseFirestore.instance.collection('roster');

  //READ
  Future<QuerySnapshot> getNews() async {
    return await news.get();
  }

  Future<QuerySnapshot> getEvents() async {
    return await events.get();
  }

  Future<QuerySnapshot> getRoster() async {
    return await news.get();
  }

  Future<QuerySnapshot> getSponsor() async {
    return await news.get();
  }

  //CREATE
  Future<void> addPost(Post post) {
    return news
        .add(post.toJson())
        .then((value) => print('Noticia creada'))
        .catchError((error) => print('Error al crear la noticia: $error'));
  }

  Future<void> addEvent(Event event) {
    return events
        .add(event.toJson())
        .then((value) => print('Evento creado'))
        .catchError((error) => print('Error al crear el evento: $error'));
  }

  Future<void> addPlayer(Player player) {
    return roster
        .add(player.toJson())
        .then((value) => print('Jugador creado'))
        .catchError((error) => print('Error al crear el jugador: $error'));
  }

  Future<void> addSponsor(Sponsor sponsor) {
    return roster
        .add(sponsor.toJson())
        .then((value) => print('Patrocinador creado'))
        .catchError(
            (error) => print('Error al crear el patrocinadore: $error'));
  }

  //DELETE
  Future<void> deletePost(id) {
    return news
        .doc(id)
        .delete()
        .then((value) => print('Post eliminado'))
        .catchError((e) => print('Error al borrar el post: $e'));
  }

  Future<void> deleteEvent(id) {
    return events
        .doc(id)
        .delete()
        .then((value) => print('Evento eliminado'))
        .catchError((e) => print('Error al borrar el evento: $e'));
  }

  Future<void> deletePlayer(id) {
    return roster
        .doc(id)
        .delete()
        .then((value) => print('Jugador eliminado'))
        .catchError((e) => print('Error al borrar el jugador: $e'));
  }

  Future<void> deleteSponsor(id) {
    return sponsors
        .doc(id)
        .delete()
        .then((value) => print('Patrocinador eliminado'))
        .catchError((e) => print('Error al borrar el patrocinador: $e'));
  }

  //UPDATE
  Future<void> updatePost(id, Post post) {
    return news
        .doc(id)
        .update(post.toJson())
        .then((value) => print('Noticia actualizada'))
        .catchError((error) => print('Error al actualizar la noticia: $error'));
  }

  Future<void> updateEvent(id, Event event) {
    return events
        .doc(id)
        .update(event.toJson())
        .then((value) => print('Evento actualizado'))
        .catchError((error) => print('Error al actualizar el evento: $error'));
  }

  Future<void> updatePlayer(id, Player player) {
    return roster
        .doc(id)
        .update(player.toJson())
        .then((value) => print('Jugador actualizado'))
        .catchError((error) => print('Error al actualizar el jugador: $error'));
  }

  Future<void> updateSponsor(id, Sponsor sponsor) {
    return sponsors
        .doc(id)
        .update(sponsor.toJson())
        .then((value) => print('Patrocinador actualizado'))
        .catchError(
            (error) => print('Error al actualizar el patrocinador: $error'));
  }
}
