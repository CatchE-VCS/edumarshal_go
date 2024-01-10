import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/repository/db_repository.dart';

final attendanceRepositoryProvider = Provider((ref) => AttendanceRepository());

class AttendanceRepository {
  AttendanceRepository();

  final _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.domain,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  Future<AttendanceData?> getData() async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };

      var response = await _dio.get(
        'api/v1/attendance',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return attendanceDataFromJson(response.data);
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }

        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
    }
  }

  Future<List<PDPAttendanceData>?> getPDPData() async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };

      var response = await _dio.get(
        'api/v1/pdp-attendance?admissionNumber=${user.admissionNumber}',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return pdpAttendanceDataFromJson(response.data);
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }

        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
    }
  }
}
