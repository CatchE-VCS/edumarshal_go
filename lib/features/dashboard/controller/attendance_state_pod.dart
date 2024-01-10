import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attendanceDataProvider =
    FutureProvider.autoDispose<AttendanceData?>((ref) async {
  final response = await ref.read(attendanceRepositoryProvider).getData();
  return response;
});
