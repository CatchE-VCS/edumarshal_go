import 'package:dio/dio.dart';
import 'package:edumarshal/const/strings.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:edumarshal/features/login/repository/db_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attendanceRepositoryProvider = Provider((ref) => AttendanceRepository());

class AttendanceRepository {
  AttendanceRepository();

  final _dio = Dio(
    BaseOptions(
      baseUrl: domain,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  AttendanceData? _attendanceData;

  Future<AttendanceData?> getData() async {
    try {
      final user = await DataBaseCon().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      // var headers = {
      //   'Token':
      //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoic3R1ZGVudDAxIiwicm9sZSI6InN0dWRlbnQifQ.UkULa-lSkrgCyxlHi106ocV1261_YpI3tFbxRfk09lg'
      // };
      var response = await _dio.get(
        'api/v1/attendance',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        _attendanceData = attendanceDataFromJson(response.data);
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
      final user = await DataBaseCon().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      // var headers = {
      //   'Token':
      //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoic3R1ZGVudDAxIiwicm9sZSI6InN0dWRlbnQifQ.UkULa-lSkrgCyxlHi106ocV1261_YpI3tFbxRfk09lg'
      // };
      var response = await _dio.get(
        'api/v1/pdp-attendance?admissionNumber=${user.admissionNumber}',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print(response.data);
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
