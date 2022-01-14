import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/screen/sponsors_tab_screen/widget/sponsor_card_widget.dart';

class SponsorsTabScreen extends StatelessWidget {
  const SponsorsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, int) => SponsorCardWidget(),
    );
  }
}
