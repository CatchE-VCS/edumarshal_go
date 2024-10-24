import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class DBRepository {
  DBRepository();

  Cookie cookie = Cookie('accessToken', '');
  Cookie cookie3 = Cookie('xContextId', '');
  Cookie cookie4 = Cookie('xUserId', '');
  Cookie cookie13 = Cookie('admissionNumber', '');

  Future<Database> initializedDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'db_user_n.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE userDB (id INTEGER PRIMARY KEY, accessToken TEXT NOT NULL, tokenType TEXT, expiresIn INTEGER, xContextId TEXT, xUserId TEXT, xLogoId TEXT, xRx TEXT, expires TEXT, admissionNumber TEXT)',
        );
      },
    );
  }

  Future<Database> initializedComDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'db_userBoole.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        return await db.execute(
          'CREATE TABLE checkBoole(id INTEGER PRIMARY KEY, boole INTEGER NOT NULL)',
        );
      },
    );
  }

// insert data
  Future<int> insertUser(User user) async {
    int result = 0;
    // Map<String, dynamic> userMap = <String, dynamic>{};
    // userMap['id'] = user.id;
    // userMap['accessToken'] = user.accessToken;
    // userMap['tokenType'] = user.tokenType;
    // userMap['expiresIn'] = user.expiresIn;
    // userMap['xContextId'] = user.xContextId;
    // userMap['xUserId'] = user.xUserId;
    // userMap['xLogoId'] = user.xLogoId;
    // userMap['xRx'] = user.xRx;
    // userMap['pChangeSetting'] = user.pChangeSetting;
    // userMap['pChangeStatus'] = user.pChangeStatus;
    // userMap['sessionId'] = user.sessionId;
    // userMap['xToken'] = user.xToken;
    // userMap['issued'] = user.issued;
    // userMap['expires'] = user.expires;
    // if (kIsWeb) {
    //   cookie = Cookie('accessToken', user.accessToken);
    //   cookie3 = Cookie('xContextId', user.xContextId);
    //   cookie4 = Cookie('xUserId', user.xUserId);
    //   // cookie12 = Cookie('expires', user.expires);
    //   cookie13 = Cookie('admissionNumber', user.admissionNumber);
    //
    //   html.window.localStorage['accessToken'] = user.accessToken;
    //   html.window.localStorage['xContextId'] = user.xContextId;
    //   html.window.localStorage['xUserId'] = user.xUserId;
    //   html.window.localStorage['admissionNumber'] = user.admissionNumber;
    //
    //   result = 1;
    //   return result;
    // }
    if (Platform.isAndroid) {
      final Database db = await initializedDB();
      result = await db.insert('userDB', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } else if (Platform.isIOS) {
      final Database db = await initializedDB();
      result = await db.insert('userDB', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } else {
      final Database db = await initializedDB();
      result = await db.insert('userDB', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    }
  }

  // Update user
  Future<void> updateUserId(String userId) async {
    final db = await initializedDB();
    await db.update(
      'userDB',
      {'xUserId': userId},
      where: "id = ?",
      whereArgs: [1],
    );
    debugPrint('User updated successfully $userId');
  }

  Future<int> insertCom() async {
    int result = 0;
    BoolCom boolCom = BoolCom(
      id: 1,
      boole: 1,
    );
    final Database db = await initializedDB();
    result = await db.insert('checkBoole', boolCom.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

// retrieve data
  Future<List<Object?>> retrieveUser() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('userDB');
    return queryResult.map((e) => e['accessToken']).toList();
  }

  // get user by id
  Future<User?> getUserById(int userId) async {
    // if (kIsWeb) {
    //   User user = User(
    //     id: 1,
    //     accessToken: html.window.localStorage['accessToken'] ?? '',
    //     xContextId: html.window.localStorage['xContextId'] ?? '',
    //     xUserId: html.window.localStorage['xUserId'] ?? '',
    //     admissionNumber: html.window.localStorage['admissionNumber'] ?? '',
    //     tokenType: '',
    //     expiresIn: 0,
    //     xLogoId: '',
    //     xRx: '',
    //     expires: '',
    //   );
    //   return user;
    // }

    final Database db = await initializedDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'userDB',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (kDebugMode) {
      print("object");
    }
    if (maps.isNotEmpty) {
      if (kDebugMode) {
        print("data got");
      }
      return User.fromMap(maps.first);
    } else {
      if (kDebugMode) {
        print("empty");
      }
      return null;
    }
  }

  Future<List<BoolCom>> retrieveComUser() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('checkBoole');
    return queryResult.map((e) => BoolCom.fromMap(e)).toList();
  }

// delete user
  Future<void> deleteUser(int id) async {
    final db = await initializedDB();
    await db.delete(
      'userDB',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteComUser(int id) async {
    final db = await initializedDB();
    await db.delete(
      'checkBoole',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUser() async {
    final db = await initializedDB();
    await db.delete(
      'userDB',
    );
  }

  Future<void> deleteAllComUser() async {
    final db = await initializedDB();
    await db.delete(
      'checkBoole',
    );
  }

  Future<void> deleteDB() async {
    Database db = await initializedDB();
    db.execute("DROP TABLE userDB");
  }
}
