class User {
  late final int id;
  late final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String xContextId;
  final String xUserId;
  final String xRx;
  final String xLogoId;

  // final String pChangeSetting;
  // final String sessionId;
  // final String pChangeStatus;
  // final String issued;
  // final String xToken;
  final String expires;
  final String admissionNumber;

  User({
    required this.id,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.xContextId,
    required this.xUserId,
    required this.xLogoId,
    required this.xRx,
    // required this.pChangeSetting,
    // required this.pChangeStatus,
    // required this.sessionId,
    // required this.xToken,
    // required this.issued,
    required this.expires,
    required this.admissionNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'xContextId': xContextId,
      'xUserId': xUserId,
      'xLogoId': xLogoId,
      'xRx': xRx,
      // 'pChangeSetting': pChangeSetting,
      // 'pChangeStatus': pChangeStatus,
      // 'sessionId': sessionId,
      // 'xToken': xToken,
      // 'issued': issued,
      'admissionNumber': admissionNumber,
      'expires': expires,
    };
  }

  User.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        accessToken = result['accessToken'],
        tokenType = result['tokenType'],
        expiresIn = result['expiresIn'],
        xContextId = result['xContextId'],
        xUserId = result['xUserId'],
        xLogoId = result['xLogoId'],
        xRx = result['xRx'],
        // pChangeSetting = result['pChangeSetting'],
        // pChangeStatus = result['pChangeStatus'],
        // sessionId = result['sessionId'],
        // xToken = result['xToken'],
        // issued = result['issued'],
        admissionNumber = result['admissionNumber'],
        expires = result['expires'];
// @override
// String toString() {
//   return 'User{id: $id, accessToken: $accessToken, refreshToken: $refreshToken}';
// }
}

class BoolCom {
  late final int id;
  late final int boole;

  BoolCom({
    required this.id,
    required this.boole,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'boole': boole,
    };
  }

  BoolCom.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        boole = result['boole'];
}
