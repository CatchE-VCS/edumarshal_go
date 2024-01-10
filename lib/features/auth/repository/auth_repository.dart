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
      baseUrl: AppUrls.domain,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(minutes: 1),
    ),
  );

  // static const url = 'https://akgec-edumarshal-dev.onrender.com/';
  // static const loginUrl = '${domain}api/v1/login';

  // static const localUrl = 'http://localhost:8000/api/v1/login';
  // static const localUrl2 = 'http://192.168.29.111:8000/api/v1/login';

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
}
