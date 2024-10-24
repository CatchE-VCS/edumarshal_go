import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/core/router/router.gr.dart';
import 'package:edumarshal/features/auth/controller/user_id_controller.dart';
import 'package:edumarshal/features/dashboard/controller/attendance_state_pod.dart';
import 'package:edumarshal/features/profile/controller/profile_state_pod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/auth.dart';
import '../../home_nav/controller/semester_controller.dart';

@RoutePage(
  deferredLoading: true,
)
class SplashPage extends ConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DBRepository handler = DBRepository();
    handler.getUserById(1).then((value) async {
      if (value != null) {
        ref.read(attendanceDataProvider);
        ref.read(profileDataProvider);
        int semester = await ref.read(authRepositoryProvider).getSemester();
        ref.read(semesterProvider.notifier).state = semester;
        debugPrint('Semester: $semester');
        ref.read(userIdProvider.notifier).state = value.xUserId;
      }
      Future.delayed(
        const Duration(seconds: 2),
        () {
          value != null
              ? context.router.replace(
                  HiddenDrawerRoute(accessToken: value.accessToken),
                )
              : context.router.replaceNamed('/login');
        },
      );
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }

      context.router.replaceNamed('/login');
      return null;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/Aeronex.svg',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
