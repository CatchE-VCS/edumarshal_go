import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

extension LoggerExtensions<T> on T {
  void logInfo([String? message]) {
    if (kDebugMode) {
      _logger.i(message ?? toString());
    }
  }

  void logWarning([String? message]) {
    if (kDebugMode) {
      _logger.w(message ?? toString());
    }
  }

  void logError([String? message]) {
    if (kDebugMode) {
      _logger.e(message ?? toString());
    }
  }
}
