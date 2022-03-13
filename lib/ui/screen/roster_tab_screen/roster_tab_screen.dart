import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/widget/add_player_popup.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/widget/player_card_widget.dart';
import 'package:sport_team_manager/ui/widget/background_gradient_widget.dart';
import 'package:sport_team_manager/util/string_value_util.dart';

class RosterTabScreen extends ConsumerWidget {
  final Person person;

  const RosterTabScreen({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: person.isAdmin,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            size: 40.0,
          ),
          onPressed: () {
            addPlayer(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: database.allRoster,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text(something_has_gone_wrong);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Stack(
            children: [
              const BackgroundGradientWidget(),
              ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return PlayerCardWidget(
                    playerPhoto: data['photo'],
                    firstName: data['first_name'],
                    lastName: data['last_name'],
                    playerPosition: data['position'],
                    playerNumber: data['number'],
                    playerId: data['player_id'] ?? '',
                    person: person,
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  void addPlayer(BuildContext context) async {
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
              return AddPlayerPopup(admin: (person as Admin));
            },
          ),
        );
      },
    );
  }
}
