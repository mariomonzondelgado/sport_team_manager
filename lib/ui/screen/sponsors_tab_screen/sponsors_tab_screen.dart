import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_team_manager/provider/database_provider.dart';
import 'package:sport_team_manager/ui/screen/sponsors_tab_screen/widget/sponsor_card_widget.dart';

class SponsorsTabScreen extends ConsumerWidget {
  const SponsorsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return StreamBuilder<QuerySnapshot>(
      stream: database.allSponsors,
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
            return SponsorCardWidget(
              name: data['name'],
              description: data['description'],
              logo: data['logo'],
              facebook: data['facebook'],
              twitter: data['twitter'],
              instagram: data['instagram'],
              phone: data['phone'],
            );
          }).toList(),
        );
      },
    );
  }
}
