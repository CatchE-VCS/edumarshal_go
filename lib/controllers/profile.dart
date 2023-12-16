import 'package:edumarshal/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../const/strings.dart';
import 'db_controller.dart';

class ProfileController {
  Future<ProfileData?> getProfileData() async {
    try {
      final user = await DataBaseCon().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      http.Response response = await http.get(
        Uri.parse(
          '${domain}api/v1/user',
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return profileDataFromJson(response.body);
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
