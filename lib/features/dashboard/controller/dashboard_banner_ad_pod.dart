import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../const/config.dart';

final dashBannerAdProvider = Provider<BannerAd>((ref) {
  BannerAd ad = BannerAd(
    adUnitId: Config.bannerAdID1 ?? 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {
        if (kDebugMode) {
          print('Ad loaded.');
        }
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ref.invalidateSelf();
        ad.dispose();
        if (kDebugMode) {
          print('Ad failed to load: $error');
        }
      },
      // Add other listener methods if required
    ),
  );
  ad.load();
  ref.onDispose(() {
    ad.dispose();
  });
  return ad;
});
