import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<bool> openUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      } else {
        if (kDebugMode) {
          print('Could not launch $urlString');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error launching url: $e');
      }
      return false;
    }
  }

  static Future<bool> openEmail(String email, {String subject = '', String body = ''}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );
    return openUrl(emailLaunchUri.toString());
  }
}
