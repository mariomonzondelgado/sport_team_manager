import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/edit_post_screen/edit_post_screen.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/post_card_widget.dart';

class NewsTabScreen extends ConsumerWidget {
  const NewsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return StreamBuilder<QuerySnapshot>(
      stream: database.allNews,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo ha fallado');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: true ? () => editPost(context, data) : null,
              child: PostCardWidget(
                title: data['title'],
                body: data['body'],
                image: data['image'],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void editPost(BuildContext context, Map<String, dynamic> data) {
    Navigator.of(context).pushNamed(EditPostScreen.routeName, arguments: data);
  }
}
