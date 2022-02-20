import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/addNews_popup.dart';
import 'package:sport_team_manager/ui/screen/news_tab_screen/widget/post_card_widget.dart';

class NewsTabScreen extends ConsumerWidget {
  final Person person;
  NewsTabScreen({
    required this.person
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);
    return StreamBuilder<QuerySnapshot>(
      stream: database.allNews,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Algo ha fallado');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return Stack(
          children: [
            ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return PostCardWidget(
                  title: data['title'],
                  body: data['body'],
                  image:  data['image'],
                  postId: data["postId"],
                  person: person,
                );
              }).toList(),
            ),
            (person is Admin)?
            Column(
              children: [
                Expanded(
                  flex: 16,
                  child: Container(
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: (){
                              addNews(context);
                            },
                            child: const Center(
                              child: Icon(
                                Icons.add_circle,
                                size: 70,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ):
            Container(),
          ],
        );
      },
    );
  }

  void addNews(BuildContext context) async{
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          content: Builder(
            builder: (context) {
              return AddNewsPopUp(admin: (person as Admin));
            },
          ),
        );
      },
    );
  }



}

