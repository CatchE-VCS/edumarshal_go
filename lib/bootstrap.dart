import 'dart:async';
import 'dart:developer';

import 'package:edumarshal/core/local_storage/app_storage_pod.dart';
import 'package:edumarshal/firebase_options.dart';
import 'package:edumarshal/init.dart';
import 'package:edumarshal/shared/riverpod_ext/riverpod_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
// coverage:ignore-file

/// This `talker` global variable used for logging and accessible
///  to other classed or function
// coverage:ignore-file

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    // maxHistoryItems: null,
    useConsoleLogs: !kReleaseMode,
    enabled: !kReleaseMode,
  ),
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: !Platform.I.isIOS,
    ),
  ),
);

///This bootstrap function builds widget asynchronusly
///where builder function used for building your start widget.
///You can override riverpod providers ,also setup observers
///or you can put a provider container in parent
Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
  ProviderContainer? parent,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    log(errorDetails.exceptionAsString(), stackTrace: errorDetails.stack);
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  MobileAds.instance.initialize();
  unawaited(init());
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () async => runApp(
      ProviderScope(
        overrides: [
          appBoxProvider.overrideWithValue(appBox),
          ...overrides,
        ],
        observers: [
          MyObserverLogger(
            talker: talker,
          ),
          ...?observers,
        ],
        parent: parent,
        child: await builder(),
      ),
    ),
  );
}
