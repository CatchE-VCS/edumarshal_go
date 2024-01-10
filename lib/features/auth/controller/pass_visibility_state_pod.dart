import 'package:edumarshal/features/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialPasswordVisibilityPod = Provider((ref) => true);

/// This provider holds PasswordVisibilityNotifier
final passwordVisibilityPod =
    NotifierProvider<PasswordVisibilityNotifier, bool>(
  PasswordVisibilityNotifier.new,
  name: 'passwordVisibilityPod',
);
