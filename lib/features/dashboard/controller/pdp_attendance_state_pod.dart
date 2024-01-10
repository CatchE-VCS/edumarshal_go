import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdpAttendanceDataProvider =
    FutureProvider.autoDispose<List<PDPAttendanceData>?>((ref) async {
  final response = await ref.read(attendanceRepositoryProvider).getPDPData();
  return response;
});

// final pdpAttendanceDataProvider = FutureProvider.autoDispose
//     .family<List<PDPAttendanceData>?, String>((ref, admissionNumber) async {
//   final response =
//       await ref.read(attendanceRepositoryProvider).getPDPData(admissionNumber);
//   return response;
// });
