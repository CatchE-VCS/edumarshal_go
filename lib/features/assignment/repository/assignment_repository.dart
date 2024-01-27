import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/repository/db_repository.dart';
import '../model/assignment_model.dart';

final assignmentRepositoryProvider = Provider((ref) => AssignmentRepository());

class AssignmentRepository {
  AssignmentRepository();

  final _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.domain,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  Future<List<AssignmentModel>?> getData() async {
    try {
      final user = await DBRepository().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };

      var response = await _dio.get(
        'api/v1/assignment',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return assignmentModelFromList(response.data);
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
