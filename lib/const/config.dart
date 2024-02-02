import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  Config._();

  static final String? apiKey = dotenv.env['API_KEY'];
  static final String? baseUrl = dotenv.env['BASE_URL'];
  static final bool debug = dotenv.env['DEBUG'] == 'true';

  // static final String? appName = dotenv.env['APP_NAME'];
  static final String? nativeAdID1 = dotenv.env['NATIVE_AD_ID_1'];
  static final String? bannerAdID1 = dotenv.env['BANNER_AD_ID_1'];
}
