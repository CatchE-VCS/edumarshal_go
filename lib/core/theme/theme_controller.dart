import 'package:edumarshal/core/local_storage/app_storage_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///This provider stores the ThemeModeController
final themeControllerProvider =
    NotifierProvider.autoDispose<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
  name: 'themeControllerProvider',
);

///This controller class used change theme and
///get the initial theme from storage if its available
class ThemeModeController extends AutoDisposeNotifier<ThemeMode> {
  final _themeKey = "theme";

  @override
  ThemeMode build() {
    final theme = ref.watch(appStorageProvider).get(key: _themeKey);
    if (theme != null) {
      if (theme == ThemeMode.light.name) {
        return ThemeMode.light;
      } else if (theme == ThemeMode.dark.name) {
        return ThemeMode.dark;
      }
      return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  Future<void> changeTheme(ThemeMode theme) async {
    state = theme;
    await ref.read(appStorageProvider).put(key: _themeKey, value: theme.name);
  }

  Future<void> changeThemeMode() async {
    if (state == ThemeMode.light) {
      await changeTheme(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      await changeTheme(ThemeMode.system);
    } else {
      await changeTheme(ThemeMode.light);
    }
  }
}
