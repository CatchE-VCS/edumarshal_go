import 'package:edumarshal/models/pdp_att_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../const/strings.dart';
import '../models/attendance_model.dart';
import 'db_controller.dart';

class AttendanceController {
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
      http.Response response = await http.get(
        Uri.parse(
          '${domain}api/v1/attendance',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return attendanceDataFromJson(response.body);
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

  Future<List<PDPAttendanceData>?> getPDPData(String admissionNumber) async {
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
      http.Response response = await http.get(
        Uri.parse(
          '${domain}api/v1/pdp-attendance?admissionNumber=$admissionNumber',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print(response.body);
        return pdpAttendanceDataFromJson(response.body);
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
