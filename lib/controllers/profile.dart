import 'package:edumarshal/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../const/strings.dart';

import 'db_controller.dart';

class ProfileController {
  Future<ProfileData?> getData2() async {
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
          '${domain}api/v1/user',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // setState(() {
        //   isLoading = false;
        // });print(')
        print('went ');
        return profileDataFromJson(response.body);

        // if (kDebugMode) {
        //   print('Total Subjects: $totalSubjects');
        //   print('Total Present: $totalPresent');
        //   print('Total Absent: $totalAbsent');
        //   print('Total Classes: $totalClasses');
        //   print('Overall Percentage: $overallPercentage');
        //   print('Name: $name');
        //   print('Email: $email');
        // }
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
        // return AttendanceData(
        //   attendance: null,
        //   businessDays: 0,
        //   userBusinessDay: null,
        //   attendanceData: [],
        //   extraLectures: [],
        //   attendanceCopy: [],
        //   stdSubAtdDetails: StdSubAtdDetails(
        //     overallPresent: 0,
        //     overallLecture: 0,
        //     overallPercentage: 0,
        //     subjects: [],
        //     studentSubjectAttendance: [],
        //   ),
        // );
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      return null;
      // return AttendanceData(
      //   attendance: null,
      //   businessDays: 0,
      //   userBusinessDay: null,
      //   attendanceData: [],
      //   extraLectures: [],
      //   attendanceCopy: [],
      //   stdSubAtdDetails: StdSubAtdDetails(
      //     overallPresent: 0,
      //     overallLecture: 0,
      //     overallPercentage: 0,
      //     subjects: [],
      //     studentSubjectAttendance: [],
      //   ),
      // );
    }
  }
}
