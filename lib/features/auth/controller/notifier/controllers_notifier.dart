import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers_state_pod.dart';

class UsernameControllersNotifier extends Notifier<TextEditingController> {
  @override
  TextEditingController build() {
    return ref.watch(initialUsernameControllerProvider);
  }

  void updateUsername(String username) {
    state.text = username;
  }

  void clearUsername() {
    state.clear();
  }
}

class PasswordControllersNotifier extends Notifier<TextEditingController> {
  @override
  TextEditingController build() {
    return ref.watch(initialPasswordControllerProvider);
  }

  void updatePassword(String username) {
    state.text = username;
  }

  void clearPassword() {
    state.clear();
  }
}
