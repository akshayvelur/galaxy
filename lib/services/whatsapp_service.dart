import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class WhatsAppService {
  static Future<bool> launchWhatsApp({String? customMessage}) async {
    final String message = customMessage ?? AppConstants.defaultWhatsAppMessage;
    final String encodedMsg = Uri.encodeComponent(message);
    final Uri uri = Uri.parse('https://wa.me/${AppConstants.rawWhatsAppNumber}?text=$encodedMsg');

    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web link
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> makePhoneCall([String? rawNumber]) async {
    final Uri uri = Uri.parse('tel:${rawNumber ?? AppConstants.rawPhoneNumber}');
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> sendEmail([String? customSubject]) async {
    final String subject = Uri.encodeComponent(customSubject ?? 'Tour Booking Enquiry - Galaxy');
    final Uri uri = Uri.parse('mailto:${AppConstants.email}?subject=$subject');
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> openMapLocation() async {
    final Uri uri = Uri.parse('https://maps.google.com/?q=New+Delhi+India');
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      return false;
    }
  }
}
