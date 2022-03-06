import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/generated/assets.dart';
import 'package:sport_team_manager/model/admin_model.dart';
import 'package:sport_team_manager/model/person_model.dart';
import 'package:sport_team_manager/model/player_model.dart';
import 'package:sport_team_manager/repository/content_repository.dart';
import 'package:sport_team_manager/ui/screen/roster_tab_screen/widget/edit_player_popup.dart';

class PlayerCardWidget extends ConsumerWidget {
  const PlayerCardWidget({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.playerPosition,
    required this.playerNumber,
    this.playerPhoto,
    required this.playerId,
    required this.person,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String playerPosition;
  final String playerNumber;
  final String? playerPhoto;
  final String playerId;
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
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: playerPhoto != null
                      ? Image.network(
                          playerPhoto!,
                          width: 128.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Assets.imagesPlaceholder,
                          width: 128.0,
                          fit: BoxFit.cover,
                        ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$firstName $lastName',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        playerPosition,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    playerNumber,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            _editRemoveButtons(ref, _isAdmin, context),
          ],
        ),
      ),
    );
  }

  Widget _editRemoveButtons(
      WidgetRef ref, bool? _isAdmin, BuildContext context) {
    return Visibility(
      visible: _isAdmin ?? false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              // onPressed: () => editNewsPost(context),
              onPressed: () => editPlayer(context),
              icon: const Icon(
                Icons.edit_rounded,
                size: 40.0,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () async =>
                  ContentRepository.deletePlayer(ref, playerId, playerPhoto!),
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

  void editPlayer(BuildContext context) async {
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
              return EditPlayerPopup(
                admin: person as Admin,
                player: Player(
                    firstName: firstName,
                    lastName: lastName,
                    position: playerPosition,
                    number: playerNumber,
                    photoUrl: playerPhoto!,
                    playerId: playerId),
              );
            },
          ),
        );
      },
    );
  }
}
