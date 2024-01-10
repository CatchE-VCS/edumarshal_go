import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/strings.dart';
import '../../login/repository/db_controller.dart';
import '../profile.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

class ProfileRepository {
  ProfileRepository();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: domain,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  Future<ProfileData?> getProfileData() async {
    try {
      final user = await DataBaseCon().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      var response = await _dio.get(
        'api/v1/user',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return profileDataFromJson(response.data);
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
