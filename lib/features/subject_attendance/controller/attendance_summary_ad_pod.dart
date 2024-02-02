// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// final nativeAdProvider = StateProvider<NativeAd?>((ref) {
//   NativeAd nativeAd = NativeAd(
//     adUnitId: 'ca-app-pub-3940256099942544/6300978111',
//     // Replace with your ad unit ID
//     factoryId: 'listTile',
//     // The factory identifier set in platform-specific code
//     request: const AdRequest(),
//     listener: NativeAdListener(
//       onAdLoaded: (Ad ad) {
//         if (kDebugMode) {
//           print('Native Ad loaded.');
//         }
//         ref.read(nativeAdStateProvider.notifier).state = ad as NativeAd?;
//       },
//       // Add other listener methods if required
//     ),
//   )..load();
//
//   ref.onDispose(() {
//     nativeAd.dispose();
//   });
//
//   return null; // Initially, there's no ad until `onAdLoaded` is triggered.
// });
//
// final nativeAdStateProvider = StateProvider<NativeAd?>((ref) => null);
