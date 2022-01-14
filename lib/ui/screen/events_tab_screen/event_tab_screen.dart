import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/screen/events_tab_screen/widget/event_card_widget.dart';

class EventsTabScreen extends StatelessWidget {
  const EventsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, int) => EventCardWidget(),
    );
  }
}
