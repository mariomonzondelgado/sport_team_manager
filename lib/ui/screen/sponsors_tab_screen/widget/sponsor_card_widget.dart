import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/generated/assets.dart';
import 'package:sport_team_manager/util/fake_data.dart';

class SponsorCardWidget extends StatelessWidget {
  const SponsorCardWidget({Key? key}) : super(key: key);

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
            SponsorLogo(),
            SponsorNameWidget(),
            SponsorSocialButtons(),
            SponsorDescriptionWidget(),
          ],
        ),
      ),
    );
  }
}

class SponsorSocialButtons extends StatelessWidget {
  const SponsorSocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.facebook),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.twitter),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.instagram),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.whatsapp),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.mailBulk),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.phone),
        ),
      ],
    );
  }
}

class SponsorLogo extends StatelessWidget {
  const SponsorLogo({
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

class SponsorNameWidget extends StatelessWidget {
  const SponsorNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        fakeSponsorName,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
      ),
    );
  }
}

class SponsorDescriptionWidget extends StatelessWidget {
  const SponsorDescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        fakeSponsorDescription,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
