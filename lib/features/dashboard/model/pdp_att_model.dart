// To parse this JSON data, do
//
//     final pdpAttendanceData = pdpAttendanceDataFromJson(jsonString);

import 'dart:convert';

List<PDPAttendanceData> pdpAttendanceDataFromJson(List<dynamic> str) =>
    List<PDPAttendanceData>.from(str.map((x) => PDPAttendanceData.fromJson(x)));

String pdpAttendanceDataToJson(List<PDPAttendanceData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PDPAttendanceData {
  int transportAttendanceId;
  int transportVehicleId;
  int batchId;
  String admissionNumber;
  int userId;
  int organizationId;
  int attendanceMode;
  DateTime attendanceDate;
  bool isInAbsent;
  dynamic isOutAbsent;
  int userTransportStopId;
  int markedBy;
  bool isDeleted;
  DateTime dateTimeStampIns;
  DateTime dateTimeStamp;
  int masterId1;
  bool forAllExit;
  int presentDays;
  int totalDays;
  int percentage;
  dynamic studentName;
  dynamic rollNumber;

  PDPAttendanceData({
    required this.transportAttendanceId,
    required this.transportVehicleId,
    required this.batchId,
    required this.admissionNumber,
    required this.userId,
    required this.organizationId,
    required this.attendanceMode,
    required this.attendanceDate,
    required this.isInAbsent,
    required this.isOutAbsent,
    required this.userTransportStopId,
    required this.markedBy,
    required this.isDeleted,
    required this.dateTimeStampIns,
    required this.dateTimeStamp,
    required this.masterId1,
    required this.forAllExit,
    required this.presentDays,
    required this.totalDays,
    required this.percentage,
    required this.studentName,
    required this.rollNumber,
  });

  factory PDPAttendanceData.fromJson(Map<String, dynamic> json) =>
      PDPAttendanceData(
        transportAttendanceId: json["transportAttendanceId"],
        transportVehicleId: json["transportVehicleId"],
        batchId: json["batchId"],
        admissionNumber: json["admissionNumber"],
        userId: json["userId"],
        organizationId: json["organizationId"],
        attendanceMode: json["attendanceMode"],
        attendanceDate: DateTime.parse(json["attendanceDate"]),
        isInAbsent: json["isInAbsent"],
        isOutAbsent: json["isOutAbsent"],
        userTransportStopId: json["userTransportStopId"],
        markedBy: json["markedBy"],
        isDeleted: json["isDeleted"],
        dateTimeStampIns: DateTime.parse(json["dateTimeStampIns"]),
        dateTimeStamp: DateTime.parse(json["dateTimeStamp"]),
        masterId1: json["masterId1"],
        forAllExit: json["forAllExit"],
        presentDays: json["presentDays"],
        totalDays: json["totalDays"],
        percentage: json["percentage"],
        studentName: json["studentName"],
        rollNumber: json["rollNumber"],
      );

  Map<String, dynamic> toJson() => {
        "transportAttendanceId": transportAttendanceId,
        "transportVehicleId": transportVehicleId,
        "batchId": batchId,
        "admissionNumber": admissionNumber,
        "userId": userId,
        "organizationId": organizationId,
        "attendanceMode": attendanceMode,
        "attendanceDate": attendanceDate.toIso8601String(),
        "isInAbsent": isInAbsent,
        "isOutAbsent": isOutAbsent,
        "userTransportStopId": userTransportStopId,
        "markedBy": markedBy,
        "isDeleted": isDeleted,
        "dateTimeStampIns": dateTimeStampIns.toIso8601String(),
        "dateTimeStamp": dateTimeStamp.toIso8601String(),
        "masterId1": masterId1,
        "forAllExit": forAllExit,
        "presentDays": presentDays,
        "totalDays": totalDays,
        "percentage": percentage,
        "studentName": studentName,
        "rollNumber": rollNumber,
      };
}
