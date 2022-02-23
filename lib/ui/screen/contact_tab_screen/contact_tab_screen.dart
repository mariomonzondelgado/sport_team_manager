import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactTabScreen extends ConsumerWidget {
  const ContactTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Telde Canes',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 64.0,
          ),
        ),
        Image.asset(
          'assets/images/teldecanes.png',
          width: 128.0,
        ),
        _socialButtons()
      ],
    );
  }

  Row _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: 32.0,
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.facebook),
        ),
        IconButton(
          iconSize: 32.0,
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.instagram),
        ),
        IconButton(
          iconSize: 32.0,
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.twitter),
        ),
        IconButton(
          iconSize: 32.0,
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.mailBulk),
        ),
        IconButton(
          iconSize: 32.0,
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.phone),
        ),
      ],
    );
  }
}
