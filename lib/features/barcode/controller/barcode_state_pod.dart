import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../const/config.dart';

final barcodeBannerAdProvider = Provider<BannerAd>((ref) {
  BannerAd ad = BannerAd(
    adUnitId: Config.bannerAdID5!,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {
        if (kDebugMode) {
          print('Ad loaded.');
        }
      },
      // Add other listener methods if required
    ),
  )..load(); // Load the ad
  ref.onDispose(
      () => ad.dispose()); // Dispose ad once the provider is destroyed
  return ad;
});
