import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth.dart';

class PasswordVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() {
    return ref.watch(initialPasswordVisibilityPod);
  }

  void togglePasswordVisibility() {
    state = !state;
  }
}
