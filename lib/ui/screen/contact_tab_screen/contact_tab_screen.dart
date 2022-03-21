import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        width: 256.0,
      ),
    );
  }

  Widget _socialButtons() {
    const _facebookUrl = 'https://www.facebook.com/CanesAFootball';
    const _instagramUrl = 'https://www.instagram.com/canes_american_football';
    const _twitterUrl = 'https://twitter.com/footballcanes';
    const _phoneNumber = '688909196';
    const _email = 'canes.fa@gmail.com';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _facebookBtn(_facebookUrl),
              _instagramBtn(_instagramUrl),
              _twitterBtn(_twitterUrl),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _mapBtn(),
              _mailBtn(_email),
              _phoneBtn(_phoneNumber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _phoneBtn(String _phoneNumber) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.call(_phoneNumber),
        icon: const Icon(FontAwesomeIcons.phone),
      ),
    );
  }

  Widget _mailBtn(String _email) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.mailTo(_email),
        icon: const Icon(FontAwesomeIcons.mailBulk),
      ),
    );
  }

  Widget _mapBtn() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.openMap(0, 0),
        icon: const Icon(FontAwesomeIcons.locationArrow),
      ),
    );
  }

  Widget _twitterBtn(String _twitterUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.openUrl(_twitterUrl),
        icon: const Icon(FontAwesomeIcons.twitter),
      ),
    );
  }

  Widget _instagramBtn(String _instagramUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.openUrl(_instagramUrl),
        icon: const Icon(FontAwesomeIcons.instagram),
      ),
    );
  }

  Widget _facebookBtn(String _facebookUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(1.0),
            blurRadius: 10.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: IconButton(
        iconSize: 32.0,
        enableFeedback: true,
        onPressed: () => UrlLauncherUtils.openUrl(_facebookUrl),
        icon: const Icon(FontAwesomeIcons.facebook),
      ),
    );
  }
}
