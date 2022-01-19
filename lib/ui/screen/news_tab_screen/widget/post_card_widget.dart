import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.image,
  }) : super(key: key);

  final String title;
  final String body;
  final String image;

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
            PostCardImage(
              image: image,
            ),
            PostCardTitle(
              title: title,
            ),
            PostCardBody(
              body: body,
            ),
          ],
        ),
      ),
    );
  }
}

class PostCardImage extends StatelessWidget {
  const PostCardImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: 600,
        height: 240,
      ),
    );
  }
}

class PostCardTitle extends StatelessWidget {
  const PostCardTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
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
    required this.body,
  }) : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        body,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
