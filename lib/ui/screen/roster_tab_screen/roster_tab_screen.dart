import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/widget/player_card_widget.dart';

class RosterTabScreen extends ConsumerWidget {
  const RosterTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return StreamBuilder<QuerySnapshot>(
      stream: database.allRoster,
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
            return PlayerCardWidget(
              playerName: data['name'],
              playerPosition: data['position'],
              playerNumber: data['number'],
            );
          }).toList(),
        );
      },
    );
  }
}
