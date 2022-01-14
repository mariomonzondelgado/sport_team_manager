import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/generated/assets.dart';
import 'package:sport_team_manager/util/fake_data.dart';

class PlayerCardWidget extends StatelessWidget {
  const PlayerCardWidget({Key? key}) : super(key: key);

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
                    'Player Name',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Player Position',
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
                '84',
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

class EventCardTitle extends StatelessWidget {
  const EventCardTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        fakeCardTitle,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
      ),
    );
  }
}
