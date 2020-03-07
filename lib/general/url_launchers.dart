import 'package:url_launcher/url_launcher.dart';

void launchUrl(String url) async {
  /// reference 
  /// https://pub.dev/packages/url_launcher#-readme-tab-
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

launchMap(double lat, double lng) {
  launchUrl("https://maps.google.com/maps?daddr=$lat,$lng");
}
