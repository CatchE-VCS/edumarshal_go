import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edumarshal/const/app_urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

class AuthRepository {
  AuthRepository();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.domain!,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 1),
    ),
  );

  void decodeBase64(String base64String) {
    try {
      List<int> decoded = base64.decode(base64String);
      if (kDebugMode) {
        print(utf8.decode(decoded));
      } // Assuming the decoded data is UTF-8 encoded text
    } catch (e) {
      if (kDebugMode) {
        print('Invalid Base64 string: $e');
      }
    }
  }

  Future<String> forgotPassword(String admissionNumber, String dob) async {
    try {
      var res = await _dio.post(
        'api/v1/login/forget',
        data: {
          'admissionNumber': admissionNumber,
          'dob': dob,
        },
      );
      if (kDebugMode) {
        print(res.data);
      }
      if (res.statusCode == 200) {
        return 'Please change your password through the link sent on your email';
      } else {
        return 'Invalid Credentials';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'Try again later';
    }
  }

  Future<String?> login(username, password) async {
    try {
      if (kDebugMode) {
        print("Sending request");
      }
      var res = await _dio.post(
        'api/v1/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      if (kDebugMode) {
        print(res.data);
      }
      if (res.statusCode == 200) {
        // String encodedToken = res.data)['access_token'];
        // String decodedToken = utf8.decode(base64Url.decode(encodedToken));
        // print(decodedToken);
        User user = User(
          id: 1,
          accessToken: res.data['access_token'],
          tokenType: res.data['token_type'],
          expiresIn: res.data['expires_in'],
          xContextId: res.data['X-ContextId'],
          xUserId: res.data['X-UserId'],
          xLogoId: res.data['X-LogoId'],
          xRx: res.data['X-RX'],
          // pChangeSetting: res.data)['PChangeSetting'],
          // pChangeStatus: res.data)['PChangeStatus'],
          // sessionId: res.data)['SessionId'],
          // xToken: res.data)['X_Token'],
          // issued: res.data)['.issued'],
          admissionNumber: res.data['admissionNumber'],
          expires: res.data['.expires'],
        );
        if (int.parse(res.data['X-RX']) > 1) {
          return null;
        }

        await DBRepository().insertUser(user);
        return res.data['access_token'];
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<int> getSemester() async {
    try {
      User? user = await DBRepository().getUserById(1);
      if (user == null) {
        return 1;
      }
      var res = await _dio.get(
        'api/v1/semester',
        options: Options(headers: {
          'Authorization': '${user.tokenType} ${user.accessToken}',
          'X-ContextId': user.xContextId,
          'X-UserId': user.xUserId,
          'X-LogoId': user.xLogoId,
          'X-RX': user.xRx,
        }),
      );
      if (res.statusCode == 200) {
        if (res.data['semester'] == null || res.data['semester'] == 0) {
          return 1;
        }
        return res.data['semester'];
      } else {
        return 1;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 1;
    }
  }
}
