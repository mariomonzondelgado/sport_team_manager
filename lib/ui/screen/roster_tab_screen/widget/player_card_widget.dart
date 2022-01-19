import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/generated/assets.dart';

class PlayerCardWidget extends StatelessWidget {
  const PlayerCardWidget({
    Key? key,
    required this.playerName,
    required this.playerPosition,
    required this.playerNumber,
  }) : super(key: key);

  final String playerName;
  final String playerPosition;
  final String playerNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.black54,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Assets.imagesPlaceholder,
                width: 64,
                height: 64,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    playerPosition,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                playerNumber,
                style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
