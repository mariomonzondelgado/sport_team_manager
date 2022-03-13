import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/event_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/repository/content_repository.dart';
import 'package:sport_team_manager/ui/screen/events_tab_screen/widget/edit_event_popup.dart';

class EventCardWidget extends ConsumerWidget {
  const EventCardWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.person,
    required this.eventId,
  }) : super(key: key);

  final String eventId;
  final String title;
  final String body;
  final Person person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool? _isAdmin = person.isAdmin;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EventCardTitle(title: title),
            EventCardBody(body: body),
            _editRemoveButtons(_isAdmin, context, ref)
          ],
        ),
      ),
    );
  }

  Widget _editRemoveButtons(
      bool? _isAdmin, BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: _isAdmin ?? false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => editEvent(context),
              icon: const Icon(
                Icons.edit_rounded,
                size: 40.0,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () async =>
                  await ContentRepository.deleteEvent(ref, eventId),
              // await (person as Admin).deleteEvent(ref, eventId),
              icon: const Icon(
                Icons.cancel,
                size: 40.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editEvent(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10.0),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          )),
          content: Builder(
            builder: (context) {
              return EdirEventPopup(
                admin: person as Admin,
                event: Event(
                  title: title,
                  body: body,
                  eventId: eventId,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class EventCardTitle extends StatelessWidget {
  const EventCardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
            textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
      ),
    );
  }
}

class EventCardBody extends StatelessWidget {
  const EventCardBody({
    Key? key,
    required this.body,
  }) : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        body,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
