import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../const/config.dart';

final subAttBannerAdProvider =
    FutureProvider.autoDispose<BannerAd>((ref) async {
  BannerAd ad = BannerAd(
    adUnitId: Config.bannerAdID2 ?? 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {
        if (kDebugMode) {
          print('Ad loaded.');
        }
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        if (kDebugMode) {
          print('Ad failed to load: $error');
        }
      },
      // Add other listener methods if required
    ),
  );
  await ad.load(); // Load the ad immediately
  return ad;
});

final pdpAttBannerAdProvider =
    FutureProvider.autoDispose<BannerAd>((ref) async {
  BannerAd ad = BannerAd(
    adUnitId: Config.bannerAdID3 ?? 'ca-app-pub-3940256099942544/6300978111',
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
  );
  await ad.load(); // Load the ad immediately

  return ad;
});
