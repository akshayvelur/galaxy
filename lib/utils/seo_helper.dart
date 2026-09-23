import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SeoHelper {
  static void setTitle(String title) {
    if (kIsWeb) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: '$title | Galaxy Premium India Tours',
          primaryColor: 0xFF0B192C,
        ),
      );
    }
  }
}
