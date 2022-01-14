import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/generated/assets.dart';
import 'package:sport_team_manager/util/fake_data.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PostCardImage(),
            PostCardTitle(),
            PostCardBody(),
          ],
        ),
      ),
    );
  }
}

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: Image.asset(
        Assets.imagesPlaceholder,
        fit: BoxFit.cover,
        width: 600,
        height: 240,
      ),
    );
  }
}

class PostCardTitle extends StatelessWidget {
  const PostCardTitle({
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

class PostCardBody extends StatelessWidget {
  const PostCardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        fakeCardBody,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
