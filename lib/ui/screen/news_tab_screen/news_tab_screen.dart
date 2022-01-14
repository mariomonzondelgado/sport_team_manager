import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/post_card_widget.dart';

class NewsTabScreen extends StatelessWidget {
  const NewsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, int) => PostCardWidget(),
    );
  }
}
