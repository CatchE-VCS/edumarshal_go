import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:edumarshal/shared/extension/logger_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/repository/db_repository.dart';

final attendanceRepositoryProvider = Provider((ref) => AttendanceRepository());

class AttendanceRepository {
  AttendanceRepository();

  final _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.domain!,
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
      headers.forEach((key, value) {
        '$key: $value'.logInfo();
      });

      var response = await _dio.get(
        'api/v2/attendance',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        "Response: ${response.data}".logInfo();
        response.data.toString().logInfo();
        return attendanceDataFromJson(response.data);
      } else {
        'Failed to load data. Status code: ${response.statusCode}'.logError();

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError();

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
        'api/v2/pdp-attendance?admissionNumber=${user.admissionNumber}',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        response.data.logInfo();

        return pdpAttendanceDataFromJson(response.data);
      } else {
        'Failed to load data. Status code: ${response.statusCode}'.logError();

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError();

      return null;
    }
  }

  Future<AttendanceData?> getSemAtt(int sem) async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };

      var response = await _dio.get(
        'api/v2/sem-attendance?semester=$sem',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return attendanceDataFromJson(response.data);
      } else {
        'Failed to load data. Status code: ${response.statusCode}'.logError();

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError();

      return null;
    }
  }
}
