import 'dart:convert';

import 'package:edumarshal/controllers/db_controller.dart';
import 'package:edumarshal/controllers/model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Controller {
  static const url = 'https://akgec-edumarshal-dev.onrender.com/';
  static const loginUrl = '${url}api/v1/login';
  static const localUrl = 'http://localhost:8000/api/v1/login';
  static const localUrl2 = 'http://192.168.29.111:8000/api/v1/login';

  Future<String?> login(username, password) async {
    try {
      if (kDebugMode) {
        print("Sending request");
      }
      var res = await http.post(
        Uri.parse(
          // localUrl2,
          loginUrl,
        ),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: {
          'username': username,
          'password': password,
        },
      );
      if (kDebugMode) {
        print(jsonDecode(res.body));
      }
      if (res.statusCode == 200) {
        User user = User(
          id: 1,
          accessToken: jsonDecode(res.body)['access_token'],
          tokenType: jsonDecode(res.body)['token_type'],
          expiresIn: jsonDecode(res.body)['expires_in'],
          xContextId: jsonDecode(res.body)['X-ContextId'],
          xUserId: jsonDecode(res.body)['X-UserId'],
          xLogoId: jsonDecode(res.body)['X-LogoId'],
          xRx: jsonDecode(res.body)['X-RX'],
          pChangeSetting: jsonDecode(res.body)['PChangeSetting'],
          pChangeStatus: jsonDecode(res.body)['PChangeStatus'],
          sessionId: jsonDecode(res.body)['SessionId'],
          xToken: jsonDecode(res.body)['X_Token'],
          issued: jsonDecode(res.body)['.issued'],
          expires: jsonDecode(res.body)['.expires'],
        );

        await DataBaseCon().insertUser(user);
        return jsonDecode(res.body)['access_token'];
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
