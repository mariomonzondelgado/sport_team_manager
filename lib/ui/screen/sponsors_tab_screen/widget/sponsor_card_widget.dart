import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/util/url_launcher_util.dart';

class SponsorCardWidget extends StatelessWidget {
  const SponsorCardWidget({
    Key? key,
    required this.name,
    required this.description,
    this.logo,
    this.facebook,
    this.instagram,
    this.twitter,
    this.email,
    this.whatsapp,
    this.phone,
  }) : super(key: key);

  final String name;
  final String description;
  final String? logo;
  final String? facebook, instagram, twitter, email, whatsapp, phone;

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
            SponsorLogo(
              logo: logo,
            ),
            SponsorNameWidget(name: name),
            SponsorSocialButtons(
              facebook: facebook,
              instagram: instagram,
              twitter: twitter,
              email: email,
              whatsapp: phone,
              phone: phone,
            ),
            SponsorDescriptionWidget(description: description),
          ],
        ),
      ),
    );
  }
}

class SponsorSocialButtons extends StatelessWidget {
  const SponsorSocialButtons(
      {Key? key,
      this.facebook,
      this.instagram,
      this.twitter,
      this.email,
      this.whatsapp,
      this.phone})
      : super(key: key);

  final String? facebook, instagram, twitter, email, whatsapp, phone;

  @override
  Widget build(BuildContext context) {
    final hasFacebook = facebook != null;
    final hasInstagram = instagram != null;
    final hasTwitter = twitter != null;
    final hasMail = email != null;
    final hasPhone = phone != null;
    final hasWhatsapp = whatsapp != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
          visible: !hasFacebook,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.openUrl(facebook!);
            },
            icon: FaIcon(FontAwesomeIcons.facebook),
          ),
        ),
        Visibility(
          visible: !hasTwitter,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.openUrl(twitter!);
            },
            icon: FaIcon(FontAwesomeIcons.twitter),
          ),
        ),
        Visibility(
          visible: !hasInstagram,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.openUrl(instagram!);
            },
            icon: FaIcon(FontAwesomeIcons.instagram),
          ),
        ),
        Visibility(
          visible: !hasWhatsapp,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.openUrl(whatsapp!);
            },
            icon: FaIcon(FontAwesomeIcons.whatsapp),
          ),
        ),
        Visibility(
          visible: !hasMail,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.mailTo(email!);
            },
            icon: FaIcon(FontAwesomeIcons.mailBulk),
          ),
        ),
        Visibility(
          visible: !hasPhone,
          child: IconButton(
            onPressed: () {
              UrlLauncherUtils.call(phone!);
            },
            icon: FaIcon(FontAwesomeIcons.phone),
          ),
        ),
      ],
    );
  }
}

class SponsorLogo extends StatelessWidget {
  const SponsorLogo({
    Key? key,
    this.logo,
  }) : super(key: key);

  final String? logo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      child: logo != null && logo!.isNotEmpty
          ? Image.network(
              logo!,
              fit: BoxFit.cover,
              width: 600,
              height: 240,
            )
          : const SizedBox.shrink(),
    );
  }
}

class SponsorNameWidget extends StatelessWidget {
  const SponsorNameWidget({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
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
  const SponsorDescriptionWidget({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        description,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
