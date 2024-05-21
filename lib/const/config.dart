import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  Config._();

  static final String? apiKey = dotenv.env['API_KEY'];
  static final String? baseUrl = dotenv.env['BASE_URL'];
  static final bool debug = dotenv.env['DEBUG'] == 'true';

  // static final String? appName = dotenv.env['APP_NAME'];
  static final String? nativeAdID1 = dotenv.env['NATIVE_AD_ID_1'];
  static final String? bannerAdID1 = dotenv.env['BANNER_AD_ID_1'];
  static final String? bannerAdID2 = dotenv.env['BANNER_AD_ID_2'];
  static final String? bannerAdID3 = dotenv.env['BANNER_AD_ID_3'];
  static final String? bannerAdID4 = dotenv.env['BANNER_AD_ID_4'];
  static final String? bannerAdID5 = dotenv.env['BANNER_AD_ID_5'];
  static final String? bannerAdID6 = dotenv.env['BANNER_AD_ID_6'];
  static final String? bannerAdID7 = dotenv.env['BANNER_AD_ID_7'];
  static final String? bannerAdID8 = dotenv.env['BANNER_AD_ID_8'];
  static final String? bannerAdID9 = dotenv.env['BANNER_AD_ID_9'];
  static final String? bannerAdID10 = dotenv.env['BANNER_AD_ID_10'];
  static final String? bannerAdID11 = dotenv.env['BANNER_AD_ID_11'];
  static final String? bannerAdID12 = dotenv.env['BANNER_AD_ID_12'];
  static final String? bannerAdID13 = dotenv.env['BANNER_AD_ID_13'];
  static final String? bannerAdID14 = dotenv.env['BANNER_AD_ID_14'];
// static final String? interstitialAdID1 = dotenv.env['INTERSTITIAL_AD_ID_1'];
}
