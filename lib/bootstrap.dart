import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_info/platform_info.dart';
import 'package:edumarshal/core/local_storage/app_storage_pod.dart';
import 'package:edumarshal/init.dart';
import 'package:edumarshal/shared/riverpod_ext/riverpod_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

// coverage:ignore-file

/// This `talker` global variable used for logging and accessible
///  to other classed or function
// coverage:ignore-file

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    maxHistoryItems: null,
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
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(init());
  await Hive.initFlutter();
  final appBox = await Hive.openBox('appBox');

  runApp(
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
  );
}
