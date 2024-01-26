import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

final navRepositoryProvider = Provider<NavRepository>((ref) {
  return NavRepository();
});

class NavRepository {
  Future<void> rateApp() async {
    if (kIsWeb) {
      return;
    }
    //
    if (Platform.isAndroid) {
      if (await InAppReview.instance.isAvailable()) {
        InAppReview.instance.requestReview();
      }
    }

    // InAppReview.instance
    //     .openStoreListing(appStoreId: 'com.akgec.edumarshal_go');
  }
}
