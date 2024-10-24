import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/user_id_controller.dart';

final attendanceDataProvider =
    FutureProvider.autoDispose<AttendanceData?>((ref) async {
  var userId = ref.read(userIdProvider);
  if (userId.isNotEmpty) {
    var attendanceData =
        await ref.read(attendanceRepositoryProvider).getData(userId: userId);
    return attendanceData;
  }
  final response = await ref.read(attendanceRepositoryProvider).getData();
  return response;
});

final attendanceFetchProgressProvider = StateProvider<double>((ref) => 0.0);
