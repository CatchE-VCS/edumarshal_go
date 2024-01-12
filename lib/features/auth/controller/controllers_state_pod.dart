import 'package:edumarshal/features/auth/controller/notifier/controllers_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialUsernameControllerProvider =
    Provider((ref) => TextEditingController());

final initialPasswordControllerProvider =
    Provider((ref) => TextEditingController());

final usernameControllerPod =
    NotifierProvider<UsernameControllersNotifier, TextEditingController>(
  UsernameControllersNotifier.new,
  name: 'usernameControllerPod',
);

final passwordControllerPod =
    NotifierProvider<PasswordControllersNotifier, TextEditingController>(
  PasswordControllersNotifier.new,
  name: 'passwordControllerPod',
);
