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

void launchUrlWithHttp(String url) async {
  /// reference
  /// https://pub.dev/packages/url_launcher#-readme-tab-
  final urlSchema = "http://$url";
  if (await canLaunch(urlSchema)) {
    await launch(urlSchema);
  } else {
    throw 'Could not launch $url';
  }
}

launchMap(double lat, double lng) {
  launchUrl("https://maps.google.com/maps?daddr=$lat,$lng");
}

Future<bool> launchPhone(String phone) async {
  final phoneSchema = "tel:$phone";
  if (await canLaunch(phoneSchema)) {
    await launch(phoneSchema);
    return true;
  } else {
    print('Could not launch $phoneSchema');
    return false;
  }
}
