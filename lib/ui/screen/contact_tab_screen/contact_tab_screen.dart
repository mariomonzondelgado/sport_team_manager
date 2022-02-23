import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/ui/widget/background_gradient_widget.dart';
import 'package:sport_team_manager/util/url_launcher_util.dart';

class ContactTabScreen extends ConsumerWidget {
  const ContactTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        const BackgroundGradientWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _teamName(),
            _teamLogo(),
            _socialButtons(),
          ],
        ),
      ],
    );
  }

  Widget _teamLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'assets/images/teldecanes.png',
        width: 64.0,
      ),
    );
  }

  Widget _teamName() {
    return Text(
      'Telde Canes',
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        fontSize: 64.0,
      ),
    );
  }

  Widget _socialButtons() {
    final _facebookUrl = 'https://www.facebook.com/CanesAFootball';
    final _instagramUrl = 'https://www.instagram.com/canes_american_football';
    final _twitterUrl = 'https://twitter.com/footballcanes';
    final _phoneNumber = '';
    final _email = 'canes.fa@gamil.com';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.openUrl(_facebookUrl),
                icon: const Icon(FontAwesomeIcons.facebook),
              ),
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.openUrl(_instagramUrl),
                icon: const Icon(FontAwesomeIcons.instagram),
              ),
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.openUrl(_twitterUrl),
                icon: const Icon(FontAwesomeIcons.twitter),
              ),
            ],
          ),
          SizedBox(
            height: 16.0
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.openMap(0, 0),
                icon: const Icon(FontAwesomeIcons.locationArrow),
              ),
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.mailTo(_email),
                icon: const Icon(FontAwesomeIcons.mailBulk),
              ),
              IconButton(
                iconSize: 32.0,
                onPressed: () => UrlLauncherUtils.call(_phoneNumber),
                icon: const Icon(FontAwesomeIcons.phone),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
