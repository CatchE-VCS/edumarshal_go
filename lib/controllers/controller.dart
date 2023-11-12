import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Controller {
  Future<int> login(username, password) async {
    var res = await http.post(
      Uri.parse(
        'https://akgec-edumarshal-dev.onrender.com/api/login',
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
      print(jsonDecode(res.body)['access_token']);
    }
    if (res.statusCode == 200) {
      return 200;
    } else {
      return 404;
    }
  }
}
