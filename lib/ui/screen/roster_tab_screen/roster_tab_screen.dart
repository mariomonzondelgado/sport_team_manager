import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/widget/player_card_widget.dart';

class RosterTabScreen extends StatelessWidget {
  const RosterTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, int) => PlayerCardWidget(),
      // itemBuilder: (context, int) => Text('Player $int'),
    );
  }
}
