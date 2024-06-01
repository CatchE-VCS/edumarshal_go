import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///This provider gives initial value to theme segment button
final themeSelectionPod = Provider.autoDispose<Set<ThemeMode>>(
  (ref) => <ThemeMode>{ref.watch(themeControllerProvider)},
  name: "themeSelectionPod",
);
