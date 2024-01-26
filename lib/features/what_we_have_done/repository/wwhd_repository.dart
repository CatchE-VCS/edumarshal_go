import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/repository/db_repository.dart';

final whatWeHaveDoneRepositoryProvider =
    Provider<WhatWeHaveDoneRepository>((ref) {
  return WhatWeHaveDoneRepository();
});

class WhatWeHaveDoneRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getWhatWeHaveDoneOverall() async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      var response = await _dio.get(
        '${AppUrls.domain}api/v1/stats/compressed-data/overall',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'error': 'Failed to load data. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'error': 'Error fetching data: $e',
      };
    }
  }

  Future<Map<String, dynamic>> getWhatWeHaveDoneForYou() async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };
      var response = await _dio.get(
        '${AppUrls.domain}api/v1/stats/compressed-data/individual',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'error': 'Failed to load data. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'error': 'Error fetching data: $e',
      };
    }
  }

  Future<Map<String, dynamic>> getTodayData() {
    return Future.delayed(const Duration(seconds: 2), () {
      return {
        'today': 100,
        'yesterday': 200,
        'lastWeek': 300,
        'lastMonth': 400,
      };
    });
  }
}
