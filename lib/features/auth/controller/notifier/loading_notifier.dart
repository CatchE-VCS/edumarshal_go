import 'package:edumarshal/features/auth/controller/loading_state_pod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLoadingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return ref.watch(initialAuthLoadingPod);
  }

  void startLoading() {
    state = true;
  }

  void stopLoading() {
    state = false;
  }
}
