import 'package:url_launcher/url_launcher.dart';

import 'text_utils.dart';

class UrlLauncherUtils {
  static openUrl(String url) async {
    ;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static openMap(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static call(String phoneNumber) async {
    if (phoneNumber.isNotEmpty) {
      final url = 'tel:+$phoneNumber'..replaceAll('++', '+');
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static mailTo(String email) async {
    if (email.isNotEmpty && email.isEmail()) {
      final url = 'mailto:$email';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
