import 'package:flutter/foundation.dart';

class Api {
  static const String _webBaseUrl = 'http://localhost/UAS_MOBILE';
  static const String _mobileBaseUrl = 'http://10.0.2.2/UAS_MOBILE';

  static String get baseUrl {
    return kIsWeb ? _webBaseUrl : _mobileBaseUrl;
  }
}
