import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:edumarshal/features/dashboard/dashboard.dart';
import 'package:edumarshal/shared/extension/logger_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/user_id_controller.dart';
import '../../auth/model/user_model.dart';
import '../../auth/repository/db_repository.dart';

final attendanceRepositoryProvider =
    Provider((ref) => AttendanceRepository(ref));

class AttendanceRepository {
  AttendanceRepository(this.ref);

  final _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.domain!,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  var ref;

  Future<AttendanceData?> getData({String? userId}) async {
    try {
      debugPrint('Semester changed');
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': userId ?? user.xUserId,
      };
      headers.forEach((key, value) {
        '$key: $value'.logInfo;
      });

      var response = await _dio.get(
        'api/v2/attendance',
        options: Options(headers: headers),
        onReceiveProgress: (received, total) {
          ref.read(attendanceFetchProgressProvider.notifier).state =
              received / total;
          debugPrint('Received: $received, Total: $total');
        },
      );

      if (response.statusCode == 200) {
        "Response: ${response.data}".logInfo;
        response.data.toString().logInfo;
        return attendanceDataFromJson(response.data);
      } else {
        'Failed to load data. Status code: ${response.statusCode}'.logError;

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError;

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
        return pdpAttendanceDataFromJson(response.data);
      } else {
        'Failed to load data. Status code: ${response.statusCode}'.logError;

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError;

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
        'Failed to load data. Status code: ${response.statusCode}'.logError;

        return null;
      }
    } catch (e) {
      'Error fetching data: $e'.logError;

      return null;
    }
  }

  Future<String> changeUserId(String userId) async {
    try {
      User? user = await DBRepository().getUserById(1);
      if (user == null) {
        return 'Invalid Credentials';
      }

      await DBRepository().updateUserId(userId);
      return 'UserId changed to $userId';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'Try again later';
    }
  }

  Future<Map<String, dynamic>> changeSemester(int semester) async {
    try {
      debugPrint('Semester: $semester');
      User? user = await DBRepository().getUserById(1);
      if (user == null) {
        return {'message': 'Invalid Credentials', 'status': false};
      }
      var res = await Dio().get(
        'https://akgecerp.edumarshal.com/api/FinancialYearContext?loginId=${user.xUserId}&semester=$semester',
        options: Options(headers: {
          'Authorization': '${user.tokenType} ${user.accessToken}',
          'X-ContextId': user.xContextId,
          'X-UserId': user.xUserId,
          'X-LogoId': user.xLogoId,
          'X-RX': user.xRx,
        }),
      );
      if (res.statusCode == 200) {
        if (res.data['userId'] == null || res.data['userId'] == 0) {
          return {'message': 'Invalid Semester', 'status': false};
        }
        debugPrint('UserId: ${res.data['userId']}');
        ref.read(userIdProvider.notifier).state = res.data['userId'].toString();
        // await changeUserId(res.data['userId'].toString());
        return {'message': 'Semester changed to $semester', 'status': true};
      } else {
        return {'message': 'Try again later', 'status': false};
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return {'message': 'Try again later', 'status': false};
    }
  }
}
