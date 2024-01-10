import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth.dart';

final initialAuthLoadingPod = Provider((ref) => false);

/// This provider holds PasswordVisibilityNotifier
final authLoadingPod = NotifierProvider<AuthLoadingNotifier, bool>(
  AuthLoadingNotifier.new,
  name: 'authLoadingPod',
);
