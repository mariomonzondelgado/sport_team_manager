import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/events_tab_screen/widget/add_event_popup.dart';
import 'package:sport_team_manager/ui/screen/events_tab_screen/widget/event_card_widget.dart';
import 'package:sport_team_manager/ui/widget/background_gradient_widget.dart';

class EventsTabScreen extends ConsumerWidget {
  const EventsTabScreen({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: person is Admin,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            size: 40.0,
          ),
          onPressed: () {
            addEvent(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: database.allEvents,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Algo ha fallado');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Stack(
            children: [
              const BackgroundGradientWidget(),
              ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return EventCardWidget(
                    title: data['title'],
                    body: data['body'],
                    person: person,
                    eventId: data['event_id'],
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  void addEvent(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return AddEventPopup(admin: (person as Admin));
            },
          ),
        );
      },
    );
  }
}
